import 'dart:convert';
import 'dart:io';

import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/schedule.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _childrenKey = 'children';
const _eventsKey = 'events';
const _schedulesKey = 'schedules';

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

/// A different weekly schedule per seeded child, so the calendar has
/// something real to show.
const _seedSchedules = [
  Schedule(
    childId: '1',
    weekdays: {1, 2, 3, 4, 5},
    startMinutes: 7 * 60,
    endMinutes: 18 * 60,
  ),
  Schedule(
    childId: '2',
    weekdays: {1, 3, 5},
    startMinutes: 8 * 60,
    endMinutes: 17 * 60,
  ),
  Schedule(
    childId: '3',
    weekdays: {2, 4},
    startMinutes: 7 * 60 + 30,
    endMinutes: 17 * 60 + 30,
  ),
];

/// Children, their events, and the photos attached to activity notes, all
/// kept on the device. A real app would sync this with a server; this demo
/// keeps everything local, the same way MetJou does, so there is no
/// account and no server that can be down.
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

  Future<List<DayEvent>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_eventsKey) ?? [];
    return raw
        .map((s) => DayEvent.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> appendEvent(DayEvent event) async {
    final events = await loadEvents();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _eventsKey,
      [...events, event].map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<List<Schedule>> loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_schedulesKey);
    if (raw == null) {
      await saveSchedules(_seedSchedules);
      return _seedSchedules;
    }
    return raw
        .map((s) => Schedule.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveSchedules(List<Schedule> schedules) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _schedulesKey,
      schedules.map((s) => jsonEncode(s.toJson())).toList(),
    );
  }

  /// Where photos are kept. A `FutureProvider` caches this for the View,
  /// instead of resolving it again on every rebuild.
  Future<Directory> photosFolder() async {
    final base = await getApplicationDocumentsDirectory();
    final folder = Directory('${base.path}/photos');
    await folder.create(recursive: true);
    return folder;
  }

  /// Copies a picked photo into the app's own folder and returns its name,
  /// so a photo stays available even if the user deletes it from their
  /// gallery afterwards.
  Future<String> addPhoto(String sourcePath) async {
    final folder = await photosFolder();
    final ext = sourcePath.contains('.')
        ? sourcePath.substring(sourcePath.lastIndexOf('.'))
        : '.jpg';
    final name = '${DateTime.now().microsecondsSinceEpoch}$ext';
    await File(sourcePath).copy('${folder.path}/$name');
    return name;
  }
}
