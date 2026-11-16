import 'package:daycheck/features/roster/data/check_event.dart';

enum DayStatus { notArrived, present, departed }

/// A child's events for today, newest first.
List<CheckEvent> eventsFor(String childId, List<CheckEvent> events) {
  final todays = events.where((e) => e.childId == childId).toList()
    ..sort((a, b) => b.at.compareTo(a.at));
  return todays;
}

/// Derives a child's current status from their events: present after the
/// most recent check-in, departed after the most recent check-out, and
/// not arrived when there are no events at all today.
DayStatus statusFor(String childId, List<CheckEvent> events) {
  final todays = eventsFor(childId, events);
  if (todays.isEmpty) return DayStatus.notArrived;
  return todays.first.kind == CheckKind.checkIn
      ? DayStatus.present
      : DayStatus.departed;
}
