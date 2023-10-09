import 'package:supplement_to_do/core/data/database/dao/classification_dao.dart';
import '../database/db_helper.dart';
import '../database/dto/classification_dto.dart';

///## グローバル変数
const String tableName = 'm_classification';

///## m_classificationのロジック部分
class ClassificationRepository {
  final ClassificationDAO dbHelper = ClassificationDAO(DBHelper.instance);

  Future<int> addClassification(ClassificationModel classification) async {
    return await dbHelper.insertClassification(classification);
  }

  Future<List<ClassificationModel>> fetchClassificationAll() async {
    return await dbHelper.getClassificationAll();
  }

  Future<List<Map<String, dynamic>>> fetchClassificationQuery(
      ClassificationQueryOption option) async {
    return await dbHelper.classificationQuery(option);
  }

  Future<int> updateClassification(ClassificationModel classification) async {
    return await dbHelper.updateClassification(classification);
  }

  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteClassification(id);
  }
}
