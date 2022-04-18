// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const MethodChannel platform =
      MethodChannel('medyouin/local_notification');

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    /* if (payload! == "mds") {
      Get.to(() => const MedsScreen());
    }
    if (payload == "Rdv") {
      Get.to(() => const RdvScreen());
    }
    if (payload == "water") {
      Get.to(() => const WaterReminderResultat());
    } */
  }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher'),
        iOS: IOSNotificationDetails(
          //sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> cancelNotification(id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleNotification(
      int id, DateTime datetime, title, body, payload,
      {bool everyDay = false}) async {
    tz.initializeTimeZones();
    final timeZone = tz.getLocation('Africa/Casablanca');
    var scheduleNotification = datetime;

    var androidChannel = const AndroidNotificationDetails(
      "CH ID 2",
      "Ch NAME 2",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'test ticker',
    );
    var iosChannel = const IOSNotificationDetails();

    var platformChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleNotification, timeZone),
      platformChannel,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: everyDay ? DateTimeComponents.time : null,
    );
  }

  Future<void> periodicallyNotification(int id, title, body,
      {bool everyDay = false}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.daily, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }
}
