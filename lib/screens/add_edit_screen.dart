import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/date_manager_notifier.dart';

class AddEditScreen extends StatelessWidget {
  final int index;
  const AddEditScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final selectedDate = dateNotifierRead.selectedDate;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text('追加・編集画面の内容 $index'),
            Text('日付：$selectedDate')
          ],
        ),
      ),
    );
  }
}
