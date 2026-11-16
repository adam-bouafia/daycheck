import 'dart:io';

import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';
import 'package:daycheck/features/roster/data/schedule.dart';

/// Children and events kept in memory, for tests that would otherwise
/// need real `SharedPreferences` and the photos folder.
class FakeRosterRepository implements RosterRepository {
  List<Child> children = const [
    Child(
      id: '1',
      name: 'Mila de Vries',
      guardians: ['Sanne de Vries', 'Tom de Vries'],
    ),
    Child(id: '2', name: 'Noah Jansen', guardians: ['Lotte Jansen']),
  ];
  List<DayEvent> events = [];
  List<Schedule> schedules = [];

  /// Names fed to [addPhoto], in order, instead of real file copies.
  final addedPhotos = <String>[];

  /// Names fed to [addAttachment], in order, instead of real file copies.
  final addedAttachments = <String>[];

  @override
  Future<List<Child>> loadChildren() async => children;

  @override
  Future<void> saveChildren(List<Child> value) async => children = value;

  @override
  Future<List<DayEvent>> loadEvents() async => events;

  @override
  Future<void> appendEvent(DayEvent event) async => events = [...events, event];

  @override
  Future<void> saveEvents(List<DayEvent> value) async => events = value;

  @override
  Future<String> addPhoto(String sourcePath) async {
    addedPhotos.add(sourcePath);
    return 'fake-photo.jpg';
  }

  @override
  Future<Directory> photosFolder() async => Directory.systemTemp;

  @override
  Future<String> addAttachment(String sourcePath) async {
    addedAttachments.add(sourcePath);
    return 'fake-attachment.pdf';
  }

  @override
  Future<Directory> attachmentsFolder() async => Directory.systemTemp;

  @override
  Future<List<Schedule>> loadSchedules() async => schedules;

  @override
  Future<void> saveSchedules(List<Schedule> value) async => schedules = value;
}
