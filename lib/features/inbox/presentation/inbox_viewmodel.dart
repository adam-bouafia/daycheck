import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/data/inbox_repository.dart';
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

  Future<void> markRead(String id) async {
    state = [
      for (final i in state)
        if (i.id == id) i.copyWith(read: true) else i,
    ];
    await _repo.saveItems(state);
  }

  Future<void> markAllRead() async {
    state = [for (final i in state) i.copyWith(read: true)];
    await _repo.saveItems(state);
  }
}

final inboxViewModelProvider =
    NotifierProvider<InboxViewModel, List<InboxItem>>(InboxViewModel.new);
