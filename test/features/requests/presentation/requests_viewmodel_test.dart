import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../inbox/fake_inbox_repository.dart';
import '../../roster/fake_notification_service.dart';
import '../../roster/support.dart';
import '../fake_request_repository.dart';

void main() {
  late FakeRosterRepository roster;
  late FakeRequestRepository requests;
  late FakeNotificationService notifications;
  late FakeInboxRepository inbox;
  late ProviderContainer container;

  setUp(() {
    roster = FakeRosterRepository();
    requests = FakeRequestRepository();
    notifications = FakeNotificationService();
    inbox = FakeInboxRepository();
    container = ProviderContainer(
      overrides: [
        rosterRepositoryProvider.overrideWithValue(roster),
        requestRepositoryProvider.overrideWithValue(requests),
        notificationServiceProvider.overrideWithValue(notifications),
        inboxRepositoryProvider.overrideWithValue(inbox),
      ],
    );
    addTearDown(container.dispose);
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('starts empty', () async {
    container.read(requestsViewModelProvider);
    await settle();
    expect(container.read(requestsViewModelProvider), isEmpty);
  });

  test('submitting creates a pending request and notifies', () async {
    container.read(rosterViewModelProvider);
    container.read(requestsViewModelProvider);
    await settle();

    await container
        .read(requestsViewModelProvider.notifier)
        .submit(
          '1',
          RequestType.leave,
          DateTime(2026, 12, 24),
          note: 'Christmas',
          requestedBy: 'Sanne de Vries',
        );

    final state = container.read(requestsViewModelProvider);
    expect(state, hasLength(1));
    expect(state.single.status, RequestStatus.pending);
    expect(state.single.note, 'Christmas');
    expect(requests.requests, hasLength(1));
    expect(notifications.sent, hasLength(1));
    expect(notifications.sent.single.$1, contains('Mila de Vries'));
  });

  test('approving moves a request to approved without a new one', () async {
    container.read(rosterViewModelProvider);
    container.read(requestsViewModelProvider);
    await settle();
    final notifier = container.read(requestsViewModelProvider.notifier);
    await notifier.submit(
      '1',
      RequestType.extraHours,
      DateTime(2026, 12, 1),
      requestedBy: 'Tom de Vries',
    );
    final id = container.read(requestsViewModelProvider).single.id;

    await notifier.approve(id);

    final state = container.read(requestsViewModelProvider);
    expect(state, hasLength(1));
    expect(state.single.status, RequestStatus.approved);
  });

  test('cancelling moves a request to cancelled', () async {
    container.read(rosterViewModelProvider);
    container.read(requestsViewModelProvider);
    await settle();
    final notifier = container.read(requestsViewModelProvider.notifier);
    await notifier.submit(
      '1',
      RequestType.leave,
      DateTime(2026, 12, 1),
      requestedBy: 'Tom de Vries',
    );
    final id = container.read(requestsViewModelProvider).single.id;

    await notifier.cancel(id);

    expect(
      container.read(requestsViewModelProvider).single.status,
      RequestStatus.cancelled,
    );
  });
}
