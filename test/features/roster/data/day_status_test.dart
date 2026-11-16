import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:flutter_test/flutter_test.dart';

DayEvent _event(String child, DateTime at, EventKind kind) =>
    DayEvent(childId: child, at: at, kind: kind, by: 'Guardian');

void main() {
  final morning = DateTime(2026, 11, 16, 8, 0);
  final noon = DateTime(2026, 11, 16, 12, 0);
  final afternoon = DateTime(2026, 11, 16, 15, 0);

  test('not arrived with no events', () {
    expect(statusFor('1', []), DayStatus.notArrived);
  });

  test('present right after a check-in', () {
    final events = [_event('1', morning, EventKind.checkIn)];
    expect(statusFor('1', events), DayStatus.present);
  });

  test('departed after a check-out that follows the check-in', () {
    final events = [
      _event('1', morning, EventKind.checkIn),
      _event('1', noon, EventKind.checkOut),
    ];
    expect(statusFor('1', events), DayStatus.departed);
  });

  test('status follows the most recent event, regardless of list order', () {
    final events = [
      _event('1', noon, EventKind.checkOut),
      _event('1', morning, EventKind.checkIn),
    ];
    expect(statusFor('1', events), DayStatus.departed);
  });

  test("another child's events never affect this child's status", () {
    final events = [_event('2', morning, EventKind.checkIn)];
    expect(statusFor('1', events), DayStatus.notArrived);
  });

  test('an activity note after check-in does not change the status', () {
    final events = [
      _event('1', morning, EventKind.checkIn),
      _event('1', noon, EventKind.activityNote),
    ];
    expect(statusFor('1', events), DayStatus.present);
  });

  test('an activity note alone, with no check-in, is still not arrived', () {
    final events = [_event('1', morning, EventKind.activityNote)];
    expect(statusFor('1', events), DayStatus.notArrived);
  });

  test('eventsFor returns every event for this child, newest first', () {
    final events = [
      _event('1', morning, EventKind.checkIn),
      _event('2', morning, EventKind.checkIn),
      _event('1', noon, EventKind.activityNote),
      _event('1', afternoon, EventKind.checkOut),
    ];
    final result = eventsFor('1', events);
    expect(result, hasLength(3));
    expect(result.first.at, afternoon);
    expect(result.last.at, morning);
  });

  test('attendanceFor skips activity notes', () {
    final events = [
      _event('1', morning, EventKind.checkIn),
      _event('1', noon, EventKind.activityNote),
      _event('1', afternoon, EventKind.checkOut),
    ];
    final result = attendanceFor('1', events);
    expect(result, hasLength(2));
    expect(result.every((e) => e.kind != EventKind.activityNote), isTrue);
  });
}
