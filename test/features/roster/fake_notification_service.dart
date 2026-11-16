import 'package:daycheck/core/notifications/notification_service.dart';

/// Records calls instead of touching the real notifications plugin, which
/// has no platform channel to answer it in a plain widget test.
class FakeNotificationService implements NotificationService {
  final sent = <(String title, String body)>[];

  @override
  Future<void> init() async {}

  @override
  Future<void> showActivityNotification(String title, String body) async {
    sent.add((title, body));
  }
}
