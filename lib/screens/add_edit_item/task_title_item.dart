import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import 'add_edit_section_title.dart';

///タイトル
class TaskTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    String initTitle = editTaskNotifierWatch.supplementName;

    final Icon icon =
        Icon(Icons.notes_rounded, color: AppColors.fontBlackBorder);
    final String title = 'タイトル';

    return Container(
      child: Column(
        children: [
          AddEditSectionTitle(icon: icon, title: title),
          Center(
            child: TaskTextBox(initTitle: initTitle),
          ),
        ],
      ),
    );
  }
}

///テキストボックス部分
class TaskTextBox extends StatefulWidget {
  final String initTitle;
  TaskTextBox({required this.initTitle});

  @override
  _TaskTextBoxState createState() => _TaskTextBoxState(initTitle: initTitle);
}

class _TaskTextBoxState extends State<TaskTextBox> {
  late TextEditingController _controller;
  final String initTitle;

  _TaskTextBoxState({required this.initTitle});

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: initTitle);
  }

  @override
  void dispose() {
    // コントローラを破棄する
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 5.0, 10.0, 5.0),
      child: Expanded(
        child: TextField(
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'ここにタイトルを入力', //プレースホルダー
            border: InputBorder.none, //ボーダーを消去
          ),
          style: TextStyle(
            color: AppColors.fontBlack,
          ),
          //テキスト編集時処理
          onChanged: (value) {
            editTaskNotifierRead.setSupplementName(value);
          },
        ),
      ),
    );
  }
}
