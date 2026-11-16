import 'package:daycheck/features/roster/data/check_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:flutter_test/flutter_test.dart';

CheckEvent _event(String child, DateTime at, CheckKind kind) =>
    CheckEvent(childId: child, at: at, kind: kind, by: 'Guardian');

void main() {
  final morning = DateTime(2026, 11, 16, 8, 0);
  final noon = DateTime(2026, 11, 16, 12, 0);

  test('not arrived with no events', () {
    expect(statusFor('1', []), DayStatus.notArrived);
  });

  test('present right after a check-in', () {
    final events = [_event('1', morning, CheckKind.checkIn)];
    expect(statusFor('1', events), DayStatus.present);
  });

  test('departed after a check-out that follows the check-in', () {
    final events = [
      _event('1', morning, CheckKind.checkIn),
      _event('1', noon, CheckKind.checkOut),
    ];
    expect(statusFor('1', events), DayStatus.departed);
  });

  test('status follows the most recent event, regardless of list order', () {
    final events = [
      _event('1', noon, CheckKind.checkOut),
      _event('1', morning, CheckKind.checkIn),
    ];
    expect(statusFor('1', events), DayStatus.departed);
  });

  test("another child's events never affect this child's status", () {
    final events = [_event('2', morning, CheckKind.checkIn)];
    expect(statusFor('1', events), DayStatus.notArrived);
  });

  test('eventsFor returns only this child, newest first', () {
    final events = [
      _event('1', morning, CheckKind.checkIn),
      _event('2', morning, CheckKind.checkIn),
      _event('1', noon, CheckKind.checkOut),
    ];
    final result = eventsFor('1', events);
    expect(result, hasLength(2));
    expect(result.first.at, noon);
    expect(result.last.at, morning);
  });
}
