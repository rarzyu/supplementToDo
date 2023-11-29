import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/classification_model.dart';
import 'package:supplement_to_do/providers/classification_list_notifier.dart';
import 'package:supplement_to_do/providers/edit_task_notifier.dart';
import '../../config/constants/color.dart';
import 'add_edit_section_title.dart';

///分類選択
class Classification extends StatelessWidget {
  final Icon icon = Icon(Icons.label_outline, color: AppColors.fontBlackBold);
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
    final classificationListNotifierRead =
        context.read<ClassificationListNotifier>();
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    String classificationName = editTaskNotifierWatch.classificationName;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeBackGray,
            shadowColor: Colors.black),
        onPressed: () {
          //モーダルを開く前に、DBから取得
          classificationListNotifierRead.getClassificationListModelForDB();
          ClassificationSelectModal().showCustomModal(context);
        },
        child: Text(
          classificationName == '' ? '分類を選択' : classificationName,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.fontBlackBold),
        ),
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
                          AddEditModal(isEditMode: false, index: 0)
                              .showAddEditModal(context);
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
///表示用のリストとDBは別管理だが、更新タイミングは同じにしている
class ClassificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final classificationListNotifierWatch =
        context.watch<ClassificationListNotifier>();
    List classifications = classificationListNotifierWatch.classifications;
    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.fontBlackBold,
        fontSize: 14.0);

    return Container(
      height: classifications.length > 9 //アイテム数が10を超える場合は高さを固定化する
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
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    return GestureDetector(
      //タップ領域をpaddingなども含めるようにする
      behavior: HitTestBehavior.opaque,

      onTap: () {
        //リストタップ時の処理
        editTaskNotifierRead.setClassificationId(classificationModel.id);
        editTaskNotifierRead.setClassificationName(classificationModel.name);
        Navigator.pop(context);
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
                AddEditModal(isEditMode: true, index: index)
                    .showAddEditModal(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //選択中のアイテムが削除された場合、こちらも削除する
                if (classificationModel.id ==
                    editTaskNotifierRead.classificationId) {
                  editTaskNotifierRead.setClassificationId(0);
                  editTaskNotifierRead.setClassificationName('');
                }

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
  final int index;
  AddEditModal({required this.isEditMode, required this.index});

  void showAddEditModal(BuildContext context) {
    TextEditingController _controller;

    //状態管理
    final classificationListNotifierRead =
        context.read<ClassificationListNotifier>();
    ClassificationModel classification;

    //追加・更新で分岐
    if (isEditMode) {
      //更新
      classification = classificationListNotifierRead.classifications[index];
      _controller = TextEditingController(text: classification.name);
    } else {
      //追加
      _controller = TextEditingController();
      int dummy = DateTime.timestamp().hashCode;
      classification = ClassificationModel(
          id: dummy, name: '', deleted: false); //idはダミー（タイムスタンプのハッシュ値）
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('分類名を入力'),
            content: TextField(controller: _controller),
            actions: [
              TextButton(
                  onPressed: () {
                    //キャンセル処理
                    Navigator.pop(context);
                  },
                  child: Text('キャンセル')),
              TextButton(
                  onPressed: () {
                    if (isEditMode) {
                      //編集処理
                      classification.name = _controller.text;
                      classificationListNotifierRead
                          .updateClassification(classification);
                    } else {
                      //追加処理
                      classification.name = _controller.text;
                      classificationListNotifierRead
                          .addClassification(classification);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(isEditMode ? '更新' : '追加')),
            ]);
      },
    );
  }
}
