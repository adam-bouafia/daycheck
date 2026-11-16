enum CheckKind { checkIn, checkOut }

/// One drop-off or pick-up. The roster's status for a child is always
/// derived from these events (see [statusFor]), never stored separately,
/// so the log and the status can never disagree.
class CheckEvent {
  const CheckEvent({
    required this.childId,
    required this.at,
    required this.kind,
    required this.by,
  });

  final String childId;
  final DateTime at;
  final CheckKind kind;

  /// Name of the guardian who dropped off or picked up.
  final String by;

  Map<String, Object?> toJson() => {
    'childId': childId,
    'at': at.toIso8601String(),
    'kind': kind.name,
    'by': by,
  };

  factory CheckEvent.fromJson(Map<String, dynamic> json) => CheckEvent(
    childId: json['childId'] as String,
    at: DateTime.parse(json['at'] as String),
    kind: CheckKind.values.byName(json['kind'] as String),
    by: json['by'] as String,
  );
}
