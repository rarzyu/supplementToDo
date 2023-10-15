import 'package:flutter/material.dart';
import 'package:supplement_to_do/screens/home_item/date_selector.dart';
import 'package:supplement_to_do/screens/home_item/home_top_section.dart';
import 'package:supplement_to_do/screens/home_item/task_list.dart';

///画面全体
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //リスト
      body: SafeArea(
        child: Column(
          children: [TopSection(), DateSelector(), TaskList()],
        ),
      ),
    );
  }
}
