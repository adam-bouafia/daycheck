import 'dart:convert';

import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _inboxKey = 'inbox_items';

class InboxRepository {
  Future<List<InboxItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_inboxKey) ?? [];
    return raw
        .map((s) => InboxItem.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveItems(List<InboxItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _inboxKey,
      items.map((i) => jsonEncode(i.toJson())).toList(),
    );
  }
}
