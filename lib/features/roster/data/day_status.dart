import 'package:daycheck/features/roster/data/day_event.dart';

enum DayStatus { notArrived, present, departed }

/// A child's events for today, newest first.
List<DayEvent> eventsFor(String childId, List<DayEvent> events) {
  final todays = events.where((e) => e.childId == childId).toList()
    ..sort((a, b) => b.at.compareTo(a.at));
  return todays;
}

/// Only the check-in/check-out events, newest first; activity notes don't
/// change whether a child is present.
List<DayEvent> attendanceFor(String childId, List<DayEvent> events) =>
    eventsFor(
      childId,
      events,
    ).where((e) => e.kind != EventKind.activityNote).toList();

/// Derives a child's current status from their check-in/out events:
/// present after the most recent check-in, departed after the most
/// recent check-out, and not arrived when there are none today.
DayStatus statusFor(String childId, List<DayEvent> events) {
  final attendance = attendanceFor(childId, events);
  if (attendance.isEmpty) return DayStatus.notArrived;
  return attendance.first.kind == EventKind.checkIn
      ? DayStatus.present
      : DayStatus.departed;
}
