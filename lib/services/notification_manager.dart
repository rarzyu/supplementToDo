import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

///通知クラス
class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String bodyMessage = '服用時間です。';

  //通知サービスの初期化
  Future<void> init() async {
    //Androidの設定
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //iOSの設定
    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    ///初期化設定
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  ///新規通知の追加
  Future<void> scheduleNotification(
      int id, String title, DateTime scheduledDateTime) async {
    final notificationDateTime =
        tz.TZDateTime.from(scheduledDateTime, tz.local);

    // Androidの通知の詳細設定
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'supplement_notification_channel_id',
      'サプリメントToDo通知',
      channelDescription: 'サプリメントの服用時間の通知',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/notification_icon_android',
    );

    //iOSの通知の詳細設定
    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      bodyMessage,
      notificationDateTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    print('通知を追加しました: $id');
  }

  ///通知の更新
  Future<void> updateNotification(
      int id, String title, DateTime scheduledDateTime) async {
    await cancelNotification(id);
    await scheduleNotification(id, title, scheduledDateTime);
    print('通知を更新しました: $id');
  }

  ///通知の削除
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print('通知を削除しました: $id');
  }
}
