import 'package:daycheck/features/roster/data/schedule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const schedule = Schedule(
    childId: '1',
    weekdays: {1, 3, 5}, // Mon, Wed, Fri
    startMinutes: 8 * 60,
    endMinutes: 17 * 60,
  );

  test('is scheduled on a listed weekday', () {
    // Monday 2 Nov 2026.
    expect(schedule.isScheduledOn(DateTime(2026, 11, 2)), isTrue);
  });

  test('is not scheduled on a weekday not listed', () {
    // Tuesday 3 Nov 2026.
    expect(schedule.isScheduledOn(DateTime(2026, 11, 3)), isFalse);
  });

  test('round-trips through JSON', () {
    final decoded = Schedule.fromJson(schedule.toJson());
    expect(decoded.childId, schedule.childId);
    expect(decoded.weekdays, schedule.weekdays);
    expect(decoded.startMinutes, schedule.startMinutes);
    expect(decoded.endMinutes, schedule.endMinutes);
  });
}
