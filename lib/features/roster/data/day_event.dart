enum EventKind { checkIn, checkOut, activityNote }

/// One thing that happened for a child today: a check-in, a check-out, or
/// a staff activity note (with an optional photo). The roster's status
/// for a child is always derived from these events (see [statusFor]),
/// never stored separately, so the log and the status can never disagree.
class DayEvent {
  const DayEvent({
    required this.childId,
    required this.at,
    required this.kind,
    required this.by,
    this.note,
    this.photoName,
  });

  final String childId;
  final DateTime at;
  final EventKind kind;

  /// Guardian name for a check-in/out, staff name for an activity note.
  final String by;

  /// Free text for an activity note; null for a check-in/out.
  final String? note;

  /// File name inside the app's own photos folder; null when there is no
  /// photo attached.
  final String? photoName;

  Map<String, Object?> toJson() => {
    'childId': childId,
    'at': at.toIso8601String(),
    'kind': kind.name,
    'by': by,
    'note': note,
    'photoName': photoName,
  };

  factory DayEvent.fromJson(Map<String, dynamic> json) => DayEvent(
    childId: json['childId'] as String,
    at: DateTime.parse(json['at'] as String),
    kind: EventKind.values.byName(json['kind'] as String),
    by: json['by'] as String,
    note: json['note'] as String?,
    photoName: json['photoName'] as String?,
  );
}
