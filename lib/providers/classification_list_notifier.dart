import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/classification_list_model.dart';
import 'package:supplement_to_do/models/classification_model.dart';

///分類リストモデル用Provider
final classificationListProvider =
    ChangeNotifierProvider<ClassificationListNotifier>(
        create: (context) => ClassificationListNotifier());

class ClassificationListNotifier extends ChangeNotifier {
  ClassificationListModel classificationListModel;

  ClassificationListNotifier()
      : classificationListModel = ClassificationListModel(classifications: []);

  ///ゲッター
  List get classifications => classificationListModel.classifications;

  ///セッター
  ///リストの追加
  void addClassification(ClassificationModel classification) {
    classificationListModel.classifications.add(classification);
    notifyListeners();
  }

  ///リストの更新
  void updateClassification(ClassificationModel updatedClassification) {
    final index = classificationListModel.classifications.indexWhere(
        (classification) => classification.id == updatedClassification.id);

    //要素が見つかる場合のみ実行
    if (index != -1) {
      classificationListModel.classifications[index] = updatedClassification;
      notifyListeners();
    }
  }

  ///リストから削除
  void removeClassification(int id) {
    classificationListModel.classifications
        .removeWhere((classification) => classification.id == id);
    notifyListeners();
  }
}
