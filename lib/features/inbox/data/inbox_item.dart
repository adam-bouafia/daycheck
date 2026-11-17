/// What tapping a notification opens.
enum InboxLink { none, child, request }

/// One entry in the in-app notification list: an arrival, a pick-up, a
/// note, a request or a decision on one. Unlike a pop-up, it stays, so
/// the user can come back to it.
class InboxItem {
  const InboxItem({
    required this.id,
    required this.title,
    required this.body,
    required this.at,
    this.childId,
    this.readBy = const {},
    this.forStaff = true,
    this.link = InboxLink.none,
  });

  final String id;
  final String title;
  final String body;
  final DateTime at;

  /// Which child this is about. A parent only sees items about their own
  /// children.
  final String? childId;

  /// Usernames that have read it. Per account, not per phone: Sanne
  /// reading an item must not mark it read for Tom.
  final Set<String> readBy;

  /// False for news meant for a family (a check-in, a photo staff posted):
  /// staff did that themselves and don't need telling.
  final bool forStaff;
  final InboxLink link;

  bool isReadBy(String username) => readBy.contains(username);

  InboxItem readFor(String username) => InboxItem(
    id: id,
    title: title,
    body: body,
    at: at,
    childId: childId,
    readBy: {...readBy, username},
    forStaff: forStaff,
    link: link,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'at': at.toIso8601String(),
    'childId': childId,
    'readBy': readBy.toList(),
    'forStaff': forStaff,
    'link': link.name,
  };

  factory InboxItem.fromJson(Map<String, dynamic> json) => InboxItem(
    id: json['id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    at: DateTime.parse(json['at'] as String),
    childId: json['childId'] as String?,
    readBy: {...(json['readBy'] as List<dynamic>? ?? const []).cast<String>()},
    forStaff: json['forStaff'] as bool? ?? true,
    link: InboxLink.values.asNameMap()[json['link']] ?? InboxLink.none,
  );
}
