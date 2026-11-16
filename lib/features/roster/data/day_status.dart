import 'package:daycheck/features/roster/data/day_event.dart';

enum DayStatus { notArrived, present, departed, absent }

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Every event for a child, on any day, newest first. The photo gallery
/// reads this; everything about "today" goes through [eventsFor].
List<DayEvent> allEventsFor(String childId, List<DayEvent> events) =>
    events.where((e) => e.childId == childId).toList()
      ..sort((a, b) => b.at.compareTo(a.at));

/// A child's events for the day of [now] (today by default), newest
/// first, so yesterday's pick-up never shows as today's status.
List<DayEvent> eventsFor(
  String childId,
  List<DayEvent> events, {
  DateTime? now,
}) {
  final day = now ?? DateTime.now();
  return allEventsFor(
    childId,
    events,
  ).where((e) => _sameDay(e.at, day)).toList();
}

/// Only the attendance events (check-in, check-out, absent), newest
/// first; activity notes don't change where a child is.
List<DayEvent> attendanceFor(
  String childId,
  List<DayEvent> events, {
  DateTime? now,
}) => eventsFor(
  childId,
  events,
  now: now,
).where((e) => e.kind != EventKind.activityNote).toList();

/// Derives a child's status from today's most recent attendance event.
/// A child marked absent who turns up after all is checked in, and the
/// check-in, being newer, wins.
DayStatus statusFor(String childId, List<DayEvent> events, {DateTime? now}) {
  final attendance = attendanceFor(childId, events, now: now);
  if (attendance.isEmpty) return DayStatus.notArrived;
  return switch (attendance.first.kind) {
    EventKind.checkIn => DayStatus.present,
    EventKind.checkOut => DayStatus.departed,
    EventKind.absent => DayStatus.absent,
    EventKind.activityNote => DayStatus.notArrived,
  };
}
