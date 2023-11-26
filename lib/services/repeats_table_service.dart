import 'package:supplement_to_do/config/constants/db/repeats_table_constants.dart';
import 'package:supplement_to_do/core/data/database/dao/repeats_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import 'package:supplement_to_do/core/data/database/dto/repeats_dto.dart';

///繰り返しテーブルのCRUD操作
class RepeatsTableService {
  ///ID
  final int id;

  RepeatsTableService({
    required this.id,
  });

  ///ローカル変数群
  RepeatsDao repeatsDao = RepeatsDao(DBHelper.instance);

  ///IDからデータを取得
  List<RepeatsDto> getRepeatsForId() {
    List<RepeatsDto> _res = [];

    //条件用のクラスの作成
    RepeatsQueryOption queryOption = RepeatsQueryOption(
      conditions: [RepeatsTableConstants.id],
      conditionValues: [id],
    );

    //取得
    Future<List<RepeatsDto>> queryResult = repeatsDao.repeatsQuery(queryOption);
    queryResult.then((value) => _res);

    return _res;
  }
}
