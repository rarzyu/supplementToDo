import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/providers/date_manager_notifier.dart';
import 'providers/edit_task_notifier.dart';
import 'screens/home_screen.dart';

void main() {
  //true:境界を見えるようにする
  //debugPaintSizeEnabled = true;

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
        ],
        child: MaterialApp(
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
