import 'package:supplement_to_do/core/data/database/dao/classification_dao.dart';
import '../database/db_helper.dart';
import '../database/dto/classification_dto.dart';

///グローバル変数
const String tableName = 'm_classification';

///m_classificationのロジック部分
class ClassificationRepository {
  final ClassificationDao dbHelper = ClassificationDao(DBHelper.instance);

  ///INSERT
  Future<int> addClassification(ClassificationDto classification) async {
    return await dbHelper.insertClassification(classification);
  }

  ///SELECT ALL
  Future<List<ClassificationDto>> fetchClassificationAll() async {
    return await dbHelper.getClassificationAll();
  }

  ///SELECT 条件指定
  Future<List<Map<String, dynamic>>> fetchClassificationQuery(
      ClassificationQueryOption option) async {
    return await dbHelper.classificationQuery(option);
  }

  ///UPDATE
  Future<int> updateClassification(ClassificationDto classification) async {
    return await dbHelper.updateClassification(classification);
  }

  ///DELETE
  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteClassification(id);
  }
}
