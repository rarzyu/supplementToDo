import '../../lib_old/constants/db/repeats_table_constants.dart';
import '../../lib_old/core/data/database/dao/repeats_dao.dart';
import '../../lib_old/core/data/database/db_helper.dart';
import '../../lib_old/core/data/database/dto/repeats_dto.dart';

///繰り返しテーブルのCRUD操作
class RepeatsTableService {
  RepeatsDao repeatsDao = RepeatsDao(DBHelper.instance);

  ///IDからデータを取得
  Future<List<RepeatsDto>> getRepeatsForId(int id) async {
    //条件用のクラスの作成
    RepeatsQueryOption queryOption = RepeatsQueryOption(
      conditions: [RepeatsTableConstants.id],
      conditionValues: [id],
    );

    //取得
    List<RepeatsDto> _res = await repeatsDao.repeatsQuery(queryOption);
    return _res;
  }

  ///DTOでINSERT
  Future<int> insertRepeats(RepeatsDto dto) async {
    int _res = await repeatsDao.insertRepeats(dto);
    return _res;
  }

  ///DTOでUPDATE
  Future<int> updateRepeats(RepeatsDto dto) async {
    int _res = await repeatsDao.updateRepeats(dto);
    return _res;
  }

  ///IDでDELETE
  Future<int> deleteRepeats(int id) async {
    int _res = await repeatsDao.deleteRepeats(id);
    return _res;
  }
}
