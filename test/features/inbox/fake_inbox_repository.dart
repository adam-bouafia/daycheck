import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/data/inbox_repository.dart';

class FakeInboxRepository implements InboxRepository {
  List<InboxItem> items = [];

  @override
  Future<List<InboxItem>> loadItems() async => items;

  @override
  Future<void> saveItems(List<InboxItem> value) async => items = value;
}
