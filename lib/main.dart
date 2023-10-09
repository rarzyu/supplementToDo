import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/providers/date_manager_notifier.dart';
import 'screens/home/home_screen.dart';

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

    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.themeBackGray,
      ),
    );
  }
}
