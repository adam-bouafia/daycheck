import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/presentation/inbox_screen.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_inbox_repository.dart';

void main() {
  late FakeInboxRepository repo;
  late ProviderContainer container;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    repo = FakeInboxRepository();
    container = ProviderContainer(
      overrides: [inboxRepositoryProvider.overrideWithValue(repo)],
    );
    container.read(inboxViewModelProvider);
    await settle();
  });

  tearDown(() => container.dispose());

  test('a new item lands unread, newest first, and is saved', () async {
    final vm = container.read(inboxViewModelProvider.notifier);
    await vm.add('First', 'a', childId: '1');
    await vm.add('Second', 'b');

    final items = container.read(inboxViewModelProvider);
    expect(items.map((i) => i.title), ['Second', 'First']);
    expect(items.every((i) => !i.read), isTrue);
    expect(repo.items, hasLength(2));
  });

  test('marking all read clears the unread count', () async {
    final vm = container.read(inboxViewModelProvider.notifier);
    await vm.add('One', 'a');
    await vm.add('Two', 'b');
    await vm.markAllRead();

    expect(
      container.read(inboxViewModelProvider).where((i) => !i.read),
      isEmpty,
    );
  });

  test('a parent only sees items about their own children', () {
    final at = DateTime(2026, 11, 16);
    final items = [
      InboxItem(id: 'a', title: 'Mine', body: '', at: at, childId: '1'),
      InboxItem(id: 'b', title: 'Other', body: '', at: at, childId: '2'),
      InboxItem(id: 'c', title: 'General', body: '', at: at),
    ];

    expect(visibleInboxItems(items, false, {'1'}).map((i) => i.title), [
      'Mine',
      'General',
    ]);
    expect(visibleInboxItems(items, true, {}), hasLength(3));
  });

  test('staff do not see family news they caused themselves', () {
    final at = DateTime(2026, 11, 16);
    final items = [
      InboxItem(id: 'a', title: 'Arrived', body: '', at: at, forStaff: false),
      InboxItem(id: 'b', title: 'New request', body: '', at: at),
    ];

    expect(visibleInboxItems(items, true, {}).map((i) => i.title), [
      'New request',
    ]);
  });
}
