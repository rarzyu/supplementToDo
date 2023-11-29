import 'package:supplement_to_do/config/constants/db/supplements_table_constants.dart';
import 'package:supplement_to_do/core/data/database/dao/supplements_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import 'package:supplement_to_do/core/data/database/dto/supplements_dto.dart';

///サプリメントテーブルのCRUD操作
class SupplementsTableService {
  final int id;
  SupplementsTableService({
    required this.id,
  });

  ///ローカル変数群
  SupplementsDao supplementsDao = SupplementsDao(DBHelper.instance);

  ///IDからデータを取得
  List<SupplementsDto> getSupplementsForId() {
    List<SupplementsDto> _res = [];

    //条件用クラスの作成
    SupplementsQueryOption queryOption = SupplementsQueryOption(
      conditions: [SupplementsTableConstants.id],
      conditionValues: [id],
    );

    //抽出
    Future<List<SupplementsDto>> queryResult =
        supplementsDao.supplementsQuery(queryOption);
    queryResult.then((value) => _res);

    return _res;
  }

  ///INSERT
  int insertSupplements(SupplementsDto dto) {
    int _res = 0;

    //insert
    Future<int> queryResult = supplementsDao.insertSupplements(dto);
    queryResult.then((value) => _res);

    return _res;
  }
}
