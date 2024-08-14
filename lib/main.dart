import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../lib_old/constants/color.dart';
import 'providers/classification_list_provider.dart';
import 'providers/date_provider.dart';
import 'providers/task_list_provider.dart';
import 'providers/edit_task_provider.dart';
import '../lib_old/screens/home_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  //タイムゾーンを日本時間にする
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  //上記で作成したインスタンス経由で、許可ダイアログを表示するメソッドを実行
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  } else if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializeDateFormatting('ja_JP').then((_) => runApp(
        ChangeNotifierProvider(
          create: (context) => DateManagerNotifier(),
          child: MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ステータスバーの文字色を黒に
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DateManagerNotifier>(
            create: (context) => DateManagerNotifier(),
          ),
          ChangeNotifierProvider<EditTaskNotifier>(
            create: (context) => EditTaskNotifier(),
          ),
          ChangeNotifierProvider<ClassificationListNotifier>(
            create: (context) => ClassificationListNotifier(),
          ),
          ChangeNotifierProvider<TaskListNotifier>(
            create: (context) => TaskListNotifier(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // アプリケーションでサポートされるロケールのリスト
          supportedLocales: [
            const Locale('en', 'US'), //English
            const Locale('ja', 'JP'), //日本語
          ],
          // これらのデリゲートは、Materialコンポーネントのローカライズに必要
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // これによって、上記の`supportedLocales`の中から適切なロケールが選ばれる
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode ||
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },

          //実際の表示する画面
          home: HomeScreen(),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.themeBackGray,
          ),
        ));
  }
}
