import 'classification_model.dart';

///分類マスタの複数所持モデル
///メインはこっちを使う
class ClassificationListModel {
  ///分類マスタモデルのList
  List<ClassificationModel> classifications;

  ClassificationListModel({required this.classifications});
}
