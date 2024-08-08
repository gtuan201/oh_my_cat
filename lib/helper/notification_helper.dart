import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

enum NotificationInterval implements Comparable <NotificationInterval> {
  none(message: 'Không'),
  daily(message: 'Hàng ngày'),
  every3Days(message: '3 Ngày'),
  weekly(message: 'Hàng tuần'),
  monthly(message: 'Hàng tháng');

  const NotificationInterval({
    required this.message,
  });

  final String message;


  @override
  int compareTo(NotificationInterval other) => message.compareTo(other.message);
}

class NotificationHelper{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true,);

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>();
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/launcher_icon");

    const InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> schedulePeriodicNotification({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
    NotificationInterval? interval,
  }) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'oh_my_cat',
      'oh_my_cat',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    DateTimeComponents? dateTimeComponents;

    switch (interval) {
      case NotificationInterval.every3Days:
        scheduledDate = _getNext3DayInstance(scheduledDate);
        break;
      case NotificationInterval.weekly:
        dateTimeComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
      case NotificationInterval.monthly:
        dateTimeComponents = DateTimeComponents.dayOfMonthAndTime;
        break;
      case NotificationInterval.daily:
      case null:
        dateTimeComponents = DateTimeComponents.time;
        break;
      case NotificationInterval.none:
        break;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: dateTimeComponents,
      payload: interval?.toString(),
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _getNext3DayInstance(tz.TZDateTime scheduledDate) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    while (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 3));
    }
    return scheduledDate;
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotificationsExceptOne({required int exceptNotificationId}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final List<PendingNotificationRequest> pendingNotifications =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var notification in pendingNotifications) {
      if (notification.id != exceptNotificationId) {
        await flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'oh_my_cat',
      'oh_my_cat',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}