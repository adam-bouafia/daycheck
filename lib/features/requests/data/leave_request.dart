enum RequestType { leave, extraHours }

enum RequestStatus { pending, approved, cancelled }

/// A parent's request for a child to be away (leave) or stay longer
/// (extra hours) on a given date, with an approve/cancel workflow. This
/// is a genuinely different pattern from [DayEvent] (features/roster): a
/// request has a state that *transitions* (pending → approved/cancelled),
/// rather than an append-only log.
class LeaveRequest {
  const LeaveRequest({
    required this.id,
    required this.childId,
    required this.type,
    required this.date,
    this.note = '',
    required this.requestedBy,
    required this.requestedAt,
    this.status = RequestStatus.pending,
  });

  final String id;
  final String childId;
  final RequestType type;
  final DateTime date;
  final String note;
  final String requestedBy;
  final DateTime requestedAt;
  final RequestStatus status;

  LeaveRequest copyWith({RequestStatus? status}) => LeaveRequest(
    id: id,
    childId: childId,
    type: type,
    date: date,
    note: note,
    requestedBy: requestedBy,
    requestedAt: requestedAt,
    status: status ?? this.status,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'childId': childId,
    'type': type.name,
    'date': date.toIso8601String(),
    'note': note,
    'requestedBy': requestedBy,
    'requestedAt': requestedAt.toIso8601String(),
    'status': status.name,
  };

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
    id: json['id'] as String,
    childId: json['childId'] as String,
    type: RequestType.values.byName(json['type'] as String),
    date: DateTime.parse(json['date'] as String),
    note: json['note'] as String? ?? '',
    requestedBy: json['requestedBy'] as String,
    requestedAt: DateTime.parse(json['requestedAt'] as String),
    status: RequestStatus.values.byName(json['status'] as String),
  );
}
