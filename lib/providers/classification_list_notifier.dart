import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/classification_list_model.dart';
import 'package:supplement_to_do/models/classification_model.dart';
import '../core/data/database/dto/classification_dto.dart';
import '../services/classification_master_service.dart';

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

  ///DBから取得し、モデルに反映後に返却する
  void getClassificationListModelForDB() async {
    ClassificationMasterService service = ClassificationMasterService(id: 0);

    //まず初期化
    resetAll();

    //DBから全取得
    List<ClassificationDto> queryResult =
        await service.getClassificationActiveAll();

    //何も取得できなければ終了
    if (queryResult.length == 0) {
      print('classification:not found');
      return;
    }

    //データ分ループ
    for (var i = 0; i < queryResult.length; i++) {
      ClassificationModel model = ClassificationModel(
          id: queryResult[i].id,
          name: queryResult[i].name,
          deleted: queryResult[i].deleted == 0 ? false : true);
      classificationListModel.classifications.add(model);
    }

    notifyListeners();
  }

  ///セッター
  ///リストの追加
  void addClassification(ClassificationModel classification) {
    ClassificationMasterService service = ClassificationMasterService(id: 0);

    classificationListModel.classifications.add(classification);

    //DBにも追加
    service.insertClassificationForModel(classification);

    notifyListeners();
  }

  ///リストの更新
  void updateClassification(ClassificationModel updatedClassification) {
    final index = classificationListModel.classifications.indexWhere(
        (classification) => classification.id == updatedClassification.id);

    ClassificationMasterService service =
        ClassificationMasterService(id: updatedClassification.id);

    //要素が見つかる場合のみ実行
    if (index != -1) {
      classificationListModel.classifications[index] = updatedClassification;

      //DBも更新
      service.updateClassificationForModel(updatedClassification);

      notifyListeners();
    }
  }

  ///リストから削除
  void removeClassification(int id) {
    classificationListModel.classifications
        .removeWhere((classification) => classification.id == id);

    ClassificationMasterService service = ClassificationMasterService(id: id);

    //DBからも削除
    service.deleteClassification();

    notifyListeners();
  }

  ///メソッド
  ///初期化
  void resetAll() {
    classificationListModel = ClassificationListModel(classifications: []);
  }
}
