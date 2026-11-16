import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';

import '../../settings/fake_settings_repository.dart';

import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../inbox/fake_inbox_repository.dart';
import '../fake_notification_service.dart';
import '../support.dart';

void main() {
  late FakeRosterRepository repo;
  late FakeNotificationService notifications;
  late FakeInboxRepository inbox;
  late ProviderContainer container;

  setUp(() {
    repo = FakeRosterRepository();
    notifications = FakeNotificationService();
    inbox = FakeInboxRepository();
    container = ProviderContainer(
      overrides: [
        rosterRepositoryProvider.overrideWithValue(repo),
        notificationServiceProvider.overrideWithValue(notifications),
        inboxRepositoryProvider.overrideWithValue(inbox),
        settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
      ],
    );
    addTearDown(container.dispose);
  });

  test("loads the repository's children on first read", () async {
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(rosterViewModelProvider);
    expect(state.children, hasLength(2));
    expect(state.children.first.name, 'Mila de Vries');
  });

  test('checking in adds an event and makes the child present', () async {
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);

    await container
        .read(rosterViewModelProvider.notifier)
        .checkIn('1', 'Sanne de Vries');

    final state = container.read(rosterViewModelProvider);
    expect(state.statusOf('1'), DayStatus.present);
    expect(repo.events, hasLength(1));
    expect(repo.events.single.by, 'Sanne de Vries');
  });

  test('checking out after checking in makes the child departed', () async {
    final notifier = container.read(rosterViewModelProvider.notifier);
    await Future<void>.delayed(Duration.zero);

    await notifier.checkIn('1', 'Sanne de Vries');
    await notifier.checkOut('1', 'Tom de Vries');

    final state = container.read(rosterViewModelProvider);
    expect(state.statusOf('1'), DayStatus.departed);
    expect(state.eventsOf('1'), hasLength(2));
  });

  test('an activity note is recorded but does not affect attendance', () async {
    final notifier = container.read(rosterViewModelProvider.notifier);
    await Future<void>.delayed(Duration.zero);

    await notifier.addActivityNote('1', 'Played outside');

    final state = container.read(rosterViewModelProvider);
    expect(state.statusOf('1'), DayStatus.notArrived);
    expect(state.eventsOf('1').single.note, 'Played outside');
    expect(repo.addedPhotos, isEmpty);
    expect(notifications.sent, hasLength(1));
    expect(notifications.sent.single.$1, contains('Mila de Vries'));
    expect(notifications.sent.single.$2, 'Played outside');
    expect(inbox.items, hasLength(1));
    expect(inbox.items.single.childId, '1');
  });

  test('with activity pop-ups off, the note still reaches the inbox', () async {
    final settings = container.read(settingsViewModelProvider.notifier);
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);
    await settings.setActivityPopups(false);

    await container
        .read(rosterViewModelProvider.notifier)
        .addActivityNote('1', 'Nap');

    expect(notifications.sent, isEmpty);
    expect(inbox.items, hasLength(1));
  });

  test('the notification uses the language picked in Settings', () async {
    container.read(settingsViewModelProvider);
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);
    await container.read(settingsViewModelProvider.notifier).setLanguage('de');

    await container
        .read(rosterViewModelProvider.notifier)
        .addActivityNote('1', 'Malen');

    expect(notifications.sent.single.$1, 'Neue Aktivität für Mila de Vries');
  });

  test(
    'an activity note with a photo copies it through the repository',
    () async {
      final notifier = container.read(rosterViewModelProvider.notifier);
      await Future<void>.delayed(Duration.zero);

      await notifier.addActivityNote(
        '1',
        'Painting',
        photoSourcePath: '/tmp/picked.jpg',
      );

      expect(repo.addedPhotos, ['/tmp/picked.jpg']);
      final state = container.read(rosterViewModelProvider);
      expect(state.eventsOf('1').single.photoName, 'fake-photo.jpg');
    },
  );
}
