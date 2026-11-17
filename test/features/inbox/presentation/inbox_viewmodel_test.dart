import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../roster/support.dart';
import '../../session/fake_session_repository.dart';
import '../fake_inbox_repository.dart';

void main() {
  final at = DateTime(2026, 11, 16);

  group('InboxViewModel', () {
    late FakeInboxRepository repo;
    late ProviderContainer container;

    setUp(() async {
      repo = FakeInboxRepository();
      container = ProviderContainer(
        overrides: [inboxRepositoryProvider.overrideWithValue(repo)],
      );
      container.read(inboxViewModelProvider);
      await Future<void>.delayed(Duration.zero);
    });

    tearDown(() => container.dispose());

    test('a new item lands unread, newest first, and is saved', () async {
      final vm = container.read(inboxViewModelProvider.notifier);
      await vm.add('First', 'a', childId: '1');
      await vm.add('Second', 'b');

      final items = container.read(inboxViewModelProvider);
      expect(items.map((i) => i.title), ['Second', 'First']);
      expect(items.every((i) => i.readBy.isEmpty), isTrue);
      expect(repo.items, hasLength(2));
    });

    test(
      'reading is per account: Sanne reading leaves it unread for Tom',
      () async {
        final vm = container.read(inboxViewModelProvider.notifier);
        await vm.add('Mila has arrived', '', childId: '1');
        final id = container.read(inboxViewModelProvider).single.id;

        await vm.markRead(id, 'sanne');

        final item = container.read(inboxViewModelProvider).single;
        expect(item.isReadBy('sanne'), isTrue);
        expect(item.isReadBy('tom'), isFalse);
      },
    );

    test('mark all read only touches the ids it is given', () async {
      final vm = container.read(inboxViewModelProvider.notifier);
      await vm.add('Mine', '', childId: '1');
      await vm.add('Not mine', '', childId: '2');
      final mine = container
          .read(inboxViewModelProvider)
          .firstWhere((i) => i.title == 'Mine')
          .id;

      await vm.markAllRead('sanne', {mine});

      final items = container.read(inboxViewModelProvider);
      expect(items.where((i) => i.isReadBy('sanne')).single.title, 'Mine');
    });
  });

  group('visibleInboxItems', () {
    final items = [
      InboxItem(id: 'a', title: 'Mine', body: '', at: at, childId: '1'),
      InboxItem(id: 'b', title: 'Other', body: '', at: at, childId: '2'),
      InboxItem(id: 'c', title: 'General', body: '', at: at),
      InboxItem(
        id: 'd',
        title: 'Arrived',
        body: '',
        at: at,
        childId: '1',
        forStaff: false,
      ),
    ];

    test('a parent only sees items about their own children', () {
      expect(visibleInboxItems(items, false, {'1'}).map((i) => i.title), [
        'Mine',
        'Arrived',
      ]);
    });

    test('staff do not see family news they caused themselves', () {
      expect(visibleInboxItems(items, true, {}).map((i) => i.title), [
        'Mine',
        'Other',
        'General',
      ]);
    });
  });

  test('each account gets its own unread count', () async {
    final session = FakeSessionRepository('sanne');
    final inbox = FakeInboxRepository()
      ..items = [
        InboxItem(
          id: '1',
          title: 'Mila has arrived',
          body: '',
          at: at,
          childId: '1',
          forStaff: false,
          readBy: const {'tom'},
        ),
        InboxItem(
          id: '2',
          title: 'Noah has arrived',
          body: '',
          at: at,
          childId: '2',
          forStaff: false,
        ),
        InboxItem(id: '3', title: 'New leave request', body: '', at: at),
      ];
    final container = ProviderContainer(
      overrides: [
        sessionRepositoryProvider.overrideWithValue(session),
        inboxRepositoryProvider.overrideWithValue(inbox),
        rosterRepositoryProvider.overrideWithValue(FakeRosterRepository()),
      ],
    );
    addTearDown(container.dispose);
    // Listened, like the home badge is, so it stays up to date.
    container.listen(myUnreadCountProvider, (_, _) {});
    // Session, roster and inbox each load in a few async steps.
    await Future<void>.delayed(const Duration(milliseconds: 10));

    // Sanne (Mila's mother): only the Mila item, unread for her.
    expect(container.read(myUnreadCountProvider), 1);

    await container
        .read(sessionViewModelProvider.notifier)
        .signIn('tom', 'tom123');
    // Tom (Mila's father) already read it.
    expect(container.read(myUnreadCountProvider), 0);

    await container
        .read(sessionViewModelProvider.notifier)
        .signIn('lotte', 'lotte123');
    expect(container.read(myUnreadCountProvider), 1);

    await container
        .read(sessionViewModelProvider.notifier)
        .signIn('sara', 'sara123');
    // Staff: only the request, not the family arrivals.
    expect(container.read(myUnreadCountProvider), 1);
  });
}
