import 'package:supplement_to_do/core/data/database/dao/supplements_dao.dart';
import '../database/db_helper.dart';
import '../database/dto/supplements_dto.dart';

///グローバル変数
const String tableName = 't_summplements';

///t_supplementsのロジック部分
class SupplementsRepository {
  final SupplementsDao dbHelper = SupplementsDao(DBHelper.instance);

  ///INSERT
  Future<int> addClassification(SupplementsDto supplements) async {
    return await dbHelper.insertSupplements(supplements);
  }

  ///SELECT ALL
  Future<List<SupplementsDto>> fetchClassificationAll() async {
    return await dbHelper.getAllSupplements();
  }

  ///SELECT 条件指定
  Future<List<SupplementsDto>> fetchClassificationQuery(
      SupplementsQueryOption option) async {
    return await dbHelper.supplementsQuery(option);
  }

  ///UPDATE
  Future<int> updateClassification(SupplementsDto supplements) async {
    return await dbHelper.updateSupplements(supplements);
  }

  ///DELETE
  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteSupplements(id);
  }
}
