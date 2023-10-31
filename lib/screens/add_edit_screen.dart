import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/date_manager_notifier.dart';
import 'add_edit_item/add_edit_top_section.dart';
import 'add_edit_item/scheduled_date_item.dart';

class AddEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final selectedDate = dateNotifierRead.selectedDate;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //top部分
            AddEditTopSection(),
            ScheduledDate(),
            Text('日付：$selectedDate'),
          ],
        ),
      ),
    );
  }
}
