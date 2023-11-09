import 'package:flutter/material.dart';
import 'package:supplement_to_do/screens/add_edit_item/add_edit_bottom_section.dart';
import 'package:supplement_to_do/screens/add_edit_item/classification_item.dart';
import 'package:supplement_to_do/screens/add_edit_item/detail_item.dart';
import 'package:supplement_to_do/screens/add_edit_item/repeat_item.dart';
import 'package:supplement_to_do/screens/add_edit_item/task_title_item.dart';
import 'add_edit_item/add_edit_top_section.dart';
import 'add_edit_item/scheduled_date_item.dart';
import 'add_edit_item/scheduled_time_item.dart';

class AddEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // キーボードが表示されている場合、キーボードを隠す
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddEditTopSection(),
                ScheduledDate(),
                SheduledTime(),
                Repeat(),
                TaskTitle(),
                Classification(),
                Details(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AddEditBottom(),
      ),
    );
  }
}
