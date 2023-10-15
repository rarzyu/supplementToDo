import '../database/dao/repeats_dao.dart';
import '../database/db_helper.dart';
import '../database/dto/repeats_dto.dart';

///グローバル変数
const String tableName = 't_repeats';

///t_tasksのロジック部分
class RepeatsRepository {
  final RepeatsDao dbHelper = RepeatsDao(DBHelper.instance);

  ///INSERT
  Future<int> addClassification(RepeatsDto repeats) async {
    return await dbHelper.insertRepeats(repeats);
  }

  ///SELECT ALL
  Future<List<RepeatsDto>> fetchClassificationAll() async {
    return await dbHelper.getAllRepeats();
  }

  ///SELECT 条件指定
  Future<List<Map<String, dynamic>>> fetchClassificationQuery(
      RepeatsQueryOption option) async {
    return await dbHelper.repeatsQuery(option);
  }

  ///UPDATE
  Future<int> updateClassification(RepeatsDto tasks) async {
    return await dbHelper.updateRepeats(tasks);
  }

  ///DELETE
  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteRepeats(id);
  }
}
