import 'package:supplement_to_do/config/constants/db/classification_master_constants.dart';
import 'package:supplement_to_do/core/data/database/dao/classification_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import 'package:supplement_to_do/core/data/database/dto/classification_dto.dart';

///分類マスタのCRUD操作
class ClassificationMasterService {
  ///ID
  final int id;

  ClassificationMasterService({
    required this.id,
  });

  ///ローカル変数群
  ClassificationDao classificationDao = ClassificationDao(DBHelper.instance);

  ///全て取得
  List<ClassificationDto> getClassificationAll() {
    List<ClassificationDto> _res = [];

    //取得
    Future<List<ClassificationDto>> queryResult =
        classificationDao.getClassificationAll();
    queryResult.then((value) => _res);

    return _res;
  }

  ///IDからデータを取得
  List<ClassificationDto> getClassificationForId() {
    List<ClassificationDto> _res = [];

    //条件用のクラスの作成
    ClassificationQueryOption queryOption = ClassificationQueryOption(
      conditions: [ClassificationMasterConstants.id],
      conditionValues: [id],
    );

    //取得
    Future<List<ClassificationDto>> queryResult =
        classificationDao.classificationQuery(queryOption);
    queryResult.then((value) => _res);

    return _res;
  }
}
