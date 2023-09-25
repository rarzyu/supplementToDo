import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ステータスバーの文字色を黒に
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.themeBackGray,
      ),
    );
  }
}
