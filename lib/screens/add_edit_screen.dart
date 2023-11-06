import 'package:flutter/material.dart';
import 'package:supplement_to_do/screens/add_edit_item/classification_item.dart';
import 'package:supplement_to_do/screens/add_edit_item/repeat_item.dart';
import 'package:supplement_to_do/screens/add_edit_item/task_title_item.dart';
import 'add_edit_item/add_edit_top_section.dart';
import 'add_edit_item/scheduled_date_item.dart';
import 'add_edit_item/scheduled_time_item.dart';

class AddEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //top部分
            AddEditTopSection(),
            ScheduledDate(),
            SheduledTime(),
            Repeat(),
            TaskTitle(),
            Classification(),
          ],
        ),
      ),
    );
  }
}
