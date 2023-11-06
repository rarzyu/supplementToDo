import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/classification_model.dart';
import 'package:supplement_to_do/providers/classification_list_notifier.dart';
import 'package:supplement_to_do/providers/edit_task_notifier.dart';

import '../../config/constants/color.dart';
import 'add_edit_section_title.dart';

///分類選択
class Classification extends StatelessWidget {
  final Icon icon = Icon(Icons.label_outline, color: AppColors.fontBlackBorder);
  final String title = '分類';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AddEditSectionTitle(icon: icon, title: title),
          ClassificationSelectButton(),
        ],
      ),
    );
  }
}

///分類選択ボタン
class ClassificationSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    String classificationName = editTaskNotifierWatch.classificationName;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeBackGray, shadowColor: Colors.black),
      onPressed: () => ClassificationSelectModal().showCustomModal(context),
      child: Text(
        classificationName == '' ? '分類を選択' : classificationName,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.fontBlackBorder),
      ),
    );
  }
}

///モーダル画面
class ClassificationSelectModal {
  void showCustomModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClassificationList(),
                  Divider(
                    color: AppColors.borderGray,
                  ),

                  ///共通部分
                  Container(
                    alignment: Alignment.centerRight,
                    height: 40,
                    child: FloatingActionButton(
                        backgroundColor: AppColors.baseObjectDarkBlue,
                        //角丸四角に変更
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        onPressed: () {
                          //新規追加ダイアログを開く
                        },
                        child: Icon(Icons.add)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

///分類リスト
class ClassificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final classificationListNotifierWatch =
        context.watch<ClassificationListNotifier>();
    List classifications = classificationListNotifierWatch.classifications;
    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.fontBlack,
        fontSize: 14.0);

    return Container(
      height: classifications.isNotEmpty
          ? MediaQuery.of(context).size.height * 0.6
          : null,
      //アイテム数が0の場合、固定文字を表示
      child: classifications.isEmpty
          ? Center(
              child: Column(
                children: [
                  Text(
                    '分類がありません',
                    style: style,
                  ),
                  Text(
                    '下のボタンから追加してください',
                    style: style,
                  )
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true, //スクロール可能に
              itemCount: classifications.length,
              itemBuilder: (context, index) =>
                  ClassificationListItem(index: index)),
    );
  }
}

///リストアイテム
class ClassificationListItem extends StatelessWidget {
  final int index;
  ClassificationListItem({required this.index});

  @override
  Widget build(BuildContext context) {
    //状態管理
    final classificationListNotifierWatch =
        context.watch<ClassificationListNotifier>();
    ClassificationModel classificationModel =
        classificationListNotifierWatch.classifications[index];

    return GestureDetector(
      //タップ領域をpaddingなども含めるようにする
      behavior: HitTestBehavior.opaque,

      onTap: () {
        //リストタップ時の処理
      },
      child: ListTile(
        title: Text(classificationModel.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                //編集モーダルを開く
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //削除処理
                classificationListNotifierWatch
                    .removeClassification(classificationModel.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

///新規・編集モーダル
class AddEditModal {
  final bool isEditMode;
  AddEditModal({required this.isEditMode});

  void showAddEditModal(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('タスク名を入力'),
            content: TextField(controller: _controller),
            actions: [
              TextButton(
                  onPressed: () {
                    //キャンセル処理
                  },
                  child: Text('キャンセル')),
              TextButton(
                  onPressed: () {
                    //更新・追加処理
                  },
                  child: Text(isEditMode ? '更新' : '追加')),
            ]);
      },
    );
  }
}
