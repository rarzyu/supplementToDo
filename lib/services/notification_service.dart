import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///通知を追加・更新するクラス
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    tz.initializeTimeZones(); // タイムゾーンの初期化
  }

  ///新規通知を追加
  void scheduleNotificationForNewTask(
      int id, String taskTitle, DateTime scheduledDateTime) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'task_schedule_channel', // チャンネルID
      'タスクリマインダー', // チャンネル名
      channelDescription: '作成したタスクのリマインダー',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      taskTitle,
      '', // 通知の本文（必要に応じて追加）
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
