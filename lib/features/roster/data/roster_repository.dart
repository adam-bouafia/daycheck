import 'dart:convert';

import 'package:daycheck/features/roster/data/check_event.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _childrenKey = 'children';
const _eventsKey = 'events';

/// A handful of children to open the app with, instead of an empty list.
const _seedChildren = [
  Child(
    id: '1',
    name: 'Mila de Vries',
    guardians: ['Sanne de Vries', 'Tom de Vries'],
  ),
  Child(id: '2', name: 'Noah Jansen', guardians: ['Lotte Jansen']),
  Child(
    id: '3',
    name: 'Yusuf El Amrani',
    guardians: ['Amina El Amrani', 'Karim El Amrani'],
  ),
];

/// Children and their check-in/out events, kept on the device. A real app
/// would sync this with a server; this demo keeps everything local, the
/// same way MetJou does, so there is no account and no server that can be
/// down.
class RosterRepository {
  Future<List<Child>> loadChildren() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_childrenKey);
    if (raw == null) {
      await saveChildren(_seedChildren);
      return _seedChildren;
    }
    return raw
        .map((s) => Child.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveChildren(List<Child> children) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _childrenKey,
      children.map((c) => jsonEncode(c.toJson())).toList(),
    );
  }

  Future<List<CheckEvent>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_eventsKey) ?? [];
    return raw
        .map((s) => CheckEvent.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> appendEvent(CheckEvent event) async {
    final events = await loadEvents();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _eventsKey,
      [...events, event].map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
