import 'dart:io';

import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';

/// Children and events kept in memory, for tests that would otherwise
/// need real `SharedPreferences` and the photos folder.
class FakeRosterRepository implements RosterRepository {
  List<Child> children = const [
    Child(
      id: '1',
      name: 'Mila de Vries',
      guardians: ['Sanne de Vries', 'Tom de Vries'],
    ),
  ];
  List<DayEvent> events = [];

  /// Names fed to [addPhoto], in order, instead of real file copies.
  final addedPhotos = <String>[];

  @override
  Future<List<Child>> loadChildren() async => children;

  @override
  Future<void> saveChildren(List<Child> value) async => children = value;

  @override
  Future<List<DayEvent>> loadEvents() async => events;

  @override
  Future<void> appendEvent(DayEvent event) async => events = [...events, event];

  @override
  Future<String> addPhoto(String sourcePath) async {
    addedPhotos.add(sourcePath);
    return 'fake-photo.jpg';
  }

  @override
  Future<Directory> photosFolder() async => Directory.systemTemp;
}
