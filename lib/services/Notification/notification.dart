import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService notificationService =
      LocalNotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
    "chat app",
    "Local Notification",
    importance: Importance.max,
    priority: Priority.max,
  );

  Future<void> initNotificationService() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidInitializationSettings android =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings iOS = const DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await plugin.initialize(settings);
  }

  Future<void> showNotification(String title, String body) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await plugin.show(0, title, body, notificationDetails);
  }

  Future<void> scheduleNotification() async {
    tz.Location location = tz.getLocation("Asia/Kolkata");
    await plugin.zonedSchedule(
        1,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(location).add(const Duration(seconds: 5)),
        NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showPeriodicNotification() async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await plugin.periodicallyShow(2, 'repeating title', 'repeating body',
        RepeatInterval.everyMinute, notificationDetails,
        androidAllowWhileIdle: true);
  }
}
