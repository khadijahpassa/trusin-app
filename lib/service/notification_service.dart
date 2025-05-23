import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // const settings = InitializationSettings(android: android);

    // await _notifications.initialize(settings);
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      // androidAllowWhileIdle: true,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void showNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // id unik
      notification.title ?? 'Notifikasi',
      notification.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
