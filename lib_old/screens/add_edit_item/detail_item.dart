import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import 'add_edit_section_title.dart';

///詳細
class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();
    String initDetail = editTaskNotifierRead.detail;

    final Icon icon = Icon(Icons.notes_rounded, color: AppColors.fontBlackBold);
    final String title = '詳細';

    return Container(
      child: Column(
        children: [
          AddEditSectionTitle(icon: icon, title: title),
          Center(
            child: DetailTextBox(initDetail: initDetail),
          ),
        ],
      ),
    );
  }
}

///テキストボックス部分
class DetailTextBox extends StatefulWidget {
  final String initDetail;
  DetailTextBox({required this.initDetail});

  @override
  _DetailTextBoxState createState() =>
      _DetailTextBoxState(initDetail: initDetail);
}

class _DetailTextBoxState extends State<DetailTextBox> {
  late TextEditingController _controller;
  final String initDetail;

  _DetailTextBoxState({required this.initDetail});

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: initDetail);
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
      padding: EdgeInsets.fromLTRB(30.0, 0, 5.0, 0),
      height: MediaQuery.of(context).size.height * 0.25,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: '詳細を追加', //プレースホルダー
          border: InputBorder.none, //ボーダーを消去
        ),
        style: TextStyle(
          color: AppColors.fontBlack,
        ),
        //テキスト編集時処理
        onChanged: (value) {
          editTaskNotifierRead.setDetail(value);
        },
      ),
    );
  }
}
