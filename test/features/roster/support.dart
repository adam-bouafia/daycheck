import 'package:daycheck/features/roster/data/check_event.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';

/// Children and events kept in memory, for tests that would otherwise
/// need real `SharedPreferences`.
class FakeRosterRepository implements RosterRepository {
  List<Child> children = const [
    Child(
      id: '1',
      name: 'Mila de Vries',
      guardians: ['Sanne de Vries', 'Tom de Vries'],
    ),
  ];
  List<CheckEvent> events = [];

  @override
  Future<List<Child>> loadChildren() async => children;

  @override
  Future<void> saveChildren(List<Child> value) async => children = value;

  @override
  Future<List<CheckEvent>> loadEvents() async => events;

  @override
  Future<void> appendEvent(CheckEvent event) async =>
      events = [...events, event];
}
