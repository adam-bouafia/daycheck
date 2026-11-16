import 'package:daycheck/features/roster/data/check_event.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository instead of the real
/// one that reads and writes `SharedPreferences`.
final rosterRepositoryProvider = Provider<RosterRepository>(
  (ref) => RosterRepository(),
);

class RosterState {
  const RosterState({this.children = const [], this.events = const []});

  final List<Child> children;
  final List<CheckEvent> events;

  DayStatus statusOf(String childId) => statusFor(childId, events);

  List<CheckEvent> eventsOf(String childId) => eventsFor(childId, events);
}

/// Holds the roster and today's events. The View only reads [RosterState]
/// and calls [checkIn]/[checkOut]; every status shown on screen is derived
/// from the event log, never set directly.
class RosterViewModel extends Notifier<RosterState> {
  RosterRepository get _repo => ref.read(rosterRepositoryProvider);

  @override
  RosterState build() {
    _load();
    return const RosterState();
  }

  Future<void> _load() async {
    final children = await _repo.loadChildren();
    final events = await _repo.loadEvents();
    state = RosterState(children: children, events: events);
  }

  Future<void> checkIn(String childId, String by) =>
      _record(childId, by, CheckKind.checkIn);

  Future<void> checkOut(String childId, String by) =>
      _record(childId, by, CheckKind.checkOut);

  Future<void> _record(String childId, String by, CheckKind kind) async {
    final event = CheckEvent(
      childId: childId,
      at: DateTime.now(),
      kind: kind,
      by: by,
    );
    await _repo.appendEvent(event);
    state = RosterState(
      children: state.children,
      events: [...state.events, event],
    );
  }
}

final rosterViewModelProvider = NotifierProvider<RosterViewModel, RosterState>(
  RosterViewModel.new,
);
