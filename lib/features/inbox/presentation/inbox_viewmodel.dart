import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/data/inbox_repository.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository.
final inboxRepositoryProvider = Provider<InboxRepository>(
  (ref) => InboxRepository(),
);

/// Every in-app notification, newest first. Other ViewModels call [add]
/// alongside showing the OS popup (see `notificationServiceProvider`), so
/// the same event is both a transient popup and a real entry the user
/// can come back to later.
class InboxViewModel extends Notifier<List<InboxItem>> {
  InboxRepository get _repo => ref.read(inboxRepositoryProvider);

  @override
  List<InboxItem> build() {
    _load();
    return const [];
  }

  Future<void> _load() async {
    state = await _repo.loadItems();
  }

  Future<void> add(
    String title,
    String body, {
    String? childId,
    bool forStaff = true,
    InboxLink link = InboxLink.none,
  }) async {
    final item = InboxItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      body: body,
      at: DateTime.now(),
      childId: childId,
      forStaff: forStaff,
      link: link,
    );
    state = [item, ...state];
    await _repo.saveItems(state);
  }

  Future<void> markRead(String id, String username) async {
    state = [
      for (final i in state)
        if (i.id == id) i.readFor(username) else i,
    ];
    await _repo.saveItems(state);
  }

  /// Demo only.
  Future<void> clearAll() async {
    state = const [];
    await _repo.saveItems(state);
  }

  /// Marks only [ids] (the user's own visible items) read for them.
  Future<void> markAllRead(String username, Set<String> ids) async {
    state = [
      for (final i in state)
        if (ids.contains(i.id)) i.readFor(username) else i,
    ];
    await _repo.saveItems(state);
  }
}

final inboxViewModelProvider =
    NotifierProvider<InboxViewModel, List<InboxItem>>(InboxViewModel.new);

/// Which items an account may see: staff get items meant for staff; a
/// parent gets items about their own children, and nothing else.
List<InboxItem> visibleInboxItems(
  List<InboxItem> items,
  bool isStaff,
  Set<String> myChildIds,
) => [
  for (final i in items)
    if (isStaff ? i.forStaff : myChildIds.contains(i.childId)) i,
];

/// The signed-in account's own notifications. The list and both home
/// badges read this, so they can never disagree.
final myInboxProvider = Provider<List<InboxItem>>((ref) {
  // Watched before anything returns early, so the list starts loading
  // while the saved session is still being read.
  final items = ref.watch(inboxViewModelProvider);
  final children = ref.watch(rosterViewModelProvider).children;
  final session = ref.watch(sessionViewModelProvider);
  if (!session.signedIn) return const [];
  final isStaff = session.role == Role.staff;
  final myChildIds = {
    for (final c in children)
      if (c.guardians.contains(session.guardianName)) c.id,
  };
  return visibleInboxItems(items, isStaff, myChildIds);
});

/// Unread items for the signed-in account only.
final myUnreadCountProvider = Provider<int>((ref) {
  final username = ref.watch(sessionViewModelProvider).account?.username;
  if (username == null) return 0;
  return ref.watch(myInboxProvider).where((i) => !i.isReadBy(username)).length;
});
