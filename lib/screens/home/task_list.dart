import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/screens/add_edit/add_edit_screen.dart';
import '../../config/constants/color.dart';
import '../../providers/date_manager_notifier.dart';

/// タスク一覧セクション
/// セクション全体
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierWatch = context.watch<DateManagerNotifier>();

    return Expanded(
      child: ListView.builder(
          itemCount: 10000,
          itemBuilder: (context, index) => ListItem(
                index: index,
                selectedDate: dateNotifierWatch.selectedDate,
              )),
    );
  }
}

/// リストのアイテム
class ListItem extends StatelessWidget {
  final int index;
  final DateTime selectedDate;
  const ListItem({Key? key, required this.index, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String viewDate = DateFormat('yyyy.M.d').format(selectedDate);
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return AddEditScreen(index: index);
          }),
        );
      },
      child: Text('ListItem:$index  Date:$viewDate'),
    );
  }
}
