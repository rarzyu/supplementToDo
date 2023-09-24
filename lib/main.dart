import 'package:flutter/material.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(scaffoldBackgroundColor: AppColors.themeBackGray),
    );
  }
}
