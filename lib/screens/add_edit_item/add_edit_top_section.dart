import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/edit_task_notifier.dart';

///追加・編集画面の最上位セクション
class AddEditTopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();

    return Container(
      height: 50,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          Text(
            editTaskNotifierWatch.isEditMode ? "タスクの編集" : "タスクの追加",
          ),
        ],
      ),
    );
  }
}
