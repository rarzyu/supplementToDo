import 'package:supplement_to_do/config/constants/db/supplements_table_constants.dart';
import 'package:supplement_to_do/core/data/database/dao/supplements_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import 'package:supplement_to_do/core/data/database/dto/supplements_dto.dart';

///サプリメントテーブルのCRUD操作
///同名はINSERTしない
class SupplementsTableService {
  SupplementsDao supplementsDao = SupplementsDao(DBHelper.instance);

  ///IDからデータを取得
  Future<List<SupplementsDto>> getSupplementsForId(int id) async {
    //条件用クラスの作成
    SupplementsQueryOption queryOption = SupplementsQueryOption(
      conditions: [SupplementsTableConstants.id],
      conditionValues: [id],
    );

    //抽出
    List<SupplementsDto> _res =
        await supplementsDao.supplementsQuery(queryOption);
    return _res;
  }

  ///名称からデータを取得
  Future<List<SupplementsDto>> getSupplementsForName(String name) async {
    //条件用クラスの作成
    SupplementsQueryOption queryOption = SupplementsQueryOption(
      conditions: [SupplementsTableConstants.supplementName],
      conditionValues: [name],
    );

    //抽出
    List<SupplementsDto> _res =
        await supplementsDao.supplementsQuery(queryOption);
    return _res;
  }

  ///DTOでINSERT
  Future<int> insertSupplements(SupplementsDto dto) async {
    int _res = await supplementsDao.insertSupplements(dto);
    return _res;
  }

  ///DTOでUPDATE
  Future<int> updateSupplements(SupplementsDto dto) async {
    int _res = await supplementsDao.updateSupplements(dto);
    return _res;
  }

  ///IDでDELETE
  Future<int> deleteSupplements(int id) async {
    int _res = await supplementsDao.deleteSupplements(id);
    return _res;
  }
}
