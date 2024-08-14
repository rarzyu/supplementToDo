import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/classification_list_model.dart';
import '../data/models/classification_model.dart';
import '../../lib_old/core/data/database/dto/classification_dto.dart';
import '../../lib_old/services/classification_master_service.dart';

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
    ClassificationMasterService service = ClassificationMasterService();

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
  ///戻り値：true=追加完了／false=追加せず、その同名の削除を復活させる
  Future<bool> addClassification(ClassificationModel classification) async {
    ClassificationMasterService service = ClassificationMasterService();

    //同名チェック
    bool checkResult =
        await service.checkSameClassificationName(classification.name);

    //チェックに引っ掛かったら、追加せずにその値を更新する
    if (checkResult) {
      //削除済みの場合、復元する
      checkNgSameNameJob(service, classification);
      notifyListeners();
      return false;
    }

    //DBにも追加
    int id = await service.insertClassificationForModel(classification);

    //戻り値のIDをセットしてから追加
    classification.id = id;
    classificationListModel.classifications.add(classification);

    notifyListeners();

    return true;
  }

  ///リストの更新
  ///戻り値：true=更新完了／false=更新せず、その同名の削除を復活させる
  Future<bool> updateClassification(
      ClassificationModel updatedClassification) async {
    final index = classificationListModel.classifications.indexWhere(
        (classification) => classification.id == updatedClassification.id);

    ClassificationMasterService service = ClassificationMasterService();

    //要素が見つかる場合のみ実行
    if (index != -1) {
      //同名チェック
      bool checkResult =
          await service.checkSameClassificationName(updatedClassification.name);

      //チェックに引っ掛かったら更新せずにfalseを返す
      if (checkResult) {
        //削除済みの場合、復元する
        checkNgSameNameJob(service, updatedClassification);
        notifyListeners();
        return false;
      }

      //更新
      classificationListModel.classifications[index] = updatedClassification;

      //DBも更新
      service.updateClassificationForModel(updatedClassification);

      notifyListeners();
    }

    return true;
  }

  ///リストから削除
  void removeClassification(int id) {
    classificationListModel.classifications
        .removeWhere((classification) => classification.id == id);

    ClassificationMasterService service = ClassificationMasterService();

    //DBからも削除（論理）
    service.deleteClassification(id);

    notifyListeners();
  }

  ///メソッド
  ///初期化
  void resetAll() {
    classificationListModel = ClassificationListModel(classifications: []);
  }

  ///同名チェックに引っ掛かった場合の処理
  ///削除フラグをfalseにする
  void checkNgSameNameJob(ClassificationMasterService service,
      ClassificationModel classification) async {
    //データ取得
    List<ClassificationDto> queryResult =
        await service.getClassificationForName(classification.name);

    //もし、削除済みでなかった場合は何もしない
    if (queryResult[0].deleted == 0) {
      return;
    }

    //リスト用にモデルにする
    //削除フラグは、復活させるのでfalse
    ClassificationModel model = ClassificationModel(
        id: queryResult[0].id, name: queryResult[0].name, deleted: false);

    //DBの更新
    service.updateClassificationForModel(model);

    //リストにも追加
    classificationListModel.classifications.add(model);
  }
}
