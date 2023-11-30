import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../providers/alarm_status.dart';
import 'audio/audio_service_manager.dart';

class LocalNotification {
  LocalNotification._init();
  AlarmStatusModel alarmStatusModel = AlarmStatusModel();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static requestPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static scheduleAlarm(
    DateTime scheduledNotificationDateTime,
    void Function() setAlarmStatus,
  ) async {
    tz.TZDateTime scheduledTZDateTime = tz.TZDateTime.from(
      scheduledNotificationDateTime,
      tz.local,
    );
    Duration duration =
        scheduledNotificationDateTime.difference(DateTime.now());

    AndroidNotificationDetails androidPlatformChannelSpecific =
        const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.max,
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecific,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .zonedSchedule(
          0, // 알림 ID
          'Zero Bug Stop',
          '다시 집중할 시간입니다. ',
          scheduledTZDateTime, // 예약할 시간
          notificationDetails, // 알림 세부 설정
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        )
        .then((_) => {
              Future.delayed(
                duration,
                () => {
                  AudioServiceManager.play(),
                  setAlarmStatus(),
                },
              )
            });
  }

  static Future<void> sampleNotification(
    DateTime scheduledNotificationDateTime,
    void Function() setAlarmStatus,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel Id',
      'test name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .zonedSchedule(
          0,
          'Zero Bug Stop',
          '다시 집중할 시간입니다. ',
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 7)),
          platformChannelSpecifics,
          payload: 'item x',
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        )
        .then((_) => {
              Future.delayed(
                const Duration(seconds: 5),
                () => {
                  AudioServiceManager.play(),
                  setAlarmStatus(),
                },
              )
            });
  }

  static detachedAppNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecific =
        const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.max,
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecific,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // 알림 ID
      'Zero Bug가 강제 종료되었습니다. ',
      '강제 종료될 시 알람이 울리지 않으니 다시 등록해주세요 ',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // 예약할 시간
      notificationDetails, // 알림 세부 설정
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
