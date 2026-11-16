/// What tapping a notification opens.
enum InboxLink { none, child, request }

/// One entry in the in-app notification inbox: an activity note posted,
/// or a request submitted/approved/cancelled. Unlike a plain OS
/// notification popup, this is a real screen the user can come back to -
/// one of the real complaints this directly answers is "this app misses
/// an essential feature: notifications" (meaning *in the app*, not just
/// a popup that's gone once it's dismissed).
class InboxItem {
  const InboxItem({
    required this.id,
    required this.title,
    required this.body,
    required this.at,
    this.childId,
    this.read = false,
    this.forStaff = true,
    this.link = InboxLink.none,
  });

  final String id;
  final String title;
  final String body;
  final DateTime at;

  /// Which child this is about, so a parent only sees notifications for
  /// their own child or children.
  final String? childId;
  final bool read;

  /// False for news meant for a family (a check-in, a photo staff posted):
  /// staff did that themselves and don't need telling.
  final bool forStaff;
  final InboxLink link;

  InboxItem copyWith({bool? read}) => InboxItem(
    id: id,
    title: title,
    body: body,
    at: at,
    childId: childId,
    read: read ?? this.read,
    forStaff: forStaff,
    link: link,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'at': at.toIso8601String(),
    'childId': childId,
    'read': read,
    'forStaff': forStaff,
    'link': link.name,
  };

  factory InboxItem.fromJson(Map<String, dynamic> json) => InboxItem(
    id: json['id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    at: DateTime.parse(json['at'] as String),
    childId: json['childId'] as String?,
    read: json['read'] as bool? ?? false,
    forStaff: json['forStaff'] as bool? ?? true,
    link: InboxLink.values.asNameMap()[json['link']] ?? InboxLink.none,
  );
}
