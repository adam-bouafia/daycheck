/// Which days of the week a child normally attends, and the hours. Kept
/// deliberately simple for a demo: no location or age group, just whether
/// today is a scheduled day. [weekdays] uses `DateTime.weekday` values
/// (1 = Monday .. 7 = Sunday).
class Schedule {
  const Schedule({
    required this.childId,
    required this.weekdays,
    required this.startMinutes,
    required this.endMinutes,
  });

  final String childId;
  final Set<int> weekdays;
  final int startMinutes;
  final int endMinutes;

  bool isScheduledOn(DateTime day) => weekdays.contains(day.weekday);

  Map<String, Object?> toJson() => {
    'childId': childId,
    'weekdays': weekdays.toList(),
    'startMinutes': startMinutes,
    'endMinutes': endMinutes,
  };

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    childId: json['childId'] as String,
    weekdays: (json['weekdays'] as List).cast<int>().toSet(),
    startMinutes: json['startMinutes'] as int,
    endMinutes: json['endMinutes'] as int,
  );
}
