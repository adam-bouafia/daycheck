import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const _channelId = 'activity_notes';
const _channelName = 'Activity notes';
const _channelDescription = 'New activity notes posted by staff';

/// Shows a local notification when staff post a new activity note.
///
/// This demonstrates the mechanism, not a real fix for the "no
/// notifications" complaint it answers: a real fix needs a second device
/// (the parent's own phone, separate from staff's) and a server to push
/// to it. DayCheck is single-device and local-only by design, so this
/// notification fires on the same device that posted the note.
class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      settings: const InitializationSettings(android: android),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> showActivityNotification(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
      ),
    );
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
