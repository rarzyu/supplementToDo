import 'package:supplement_to_do/config/constants/db/classification_master_constants.dart';
import 'package:supplement_to_do/core/data/database/dao/classification_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import 'package:supplement_to_do/core/data/database/dto/classification_dto.dart';
import 'package:supplement_to_do/models/classification_model.dart';
import 'package:supplement_to_do/utils/date_time_common.dart';

///分類マスタのCRUD操作
class ClassificationMasterService {
  ///ローカル変数群
  ClassificationDao classificationDao = ClassificationDao(DBHelper.instance);

  ///非削除全て取得
  Future<List<ClassificationDto>> getClassificationActiveAll() async {
    //条件用のクラスの作成
    ClassificationQueryOption queryOption = ClassificationQueryOption(
      conditions: [ClassificationMasterConstants.deleted],
      conditionValues: [0], //削除フラグ＝false
      sortColumns: [ClassificationMasterConstants.id],
      isASC: [true],
    );

    //取得
    List<ClassificationDto> _res =
        await classificationDao.classificationQuery(queryOption);

    return _res;
  }

  ///IDからデータを取得
  Future<List<ClassificationDto>> getClassificationForId(int id) async {
    //条件用のクラスの作成
    ClassificationQueryOption queryOption = ClassificationQueryOption(
      conditions: [ClassificationMasterConstants.id],
      conditionValues: [id],
    );

    //取得
    List<ClassificationDto> _res =
        await classificationDao.classificationQuery(queryOption);

    return _res;
  }

  ///名称からデータを取得
  Future<List<ClassificationDto>> getClassificationForName(String name) async {
    //条件用のクラスの作成
    ClassificationQueryOption queryOption = ClassificationQueryOption(
      conditions: [ClassificationMasterConstants.name],
      conditionValues: [name],
    );

    //取得
    List<ClassificationDto> _res =
        await classificationDao.classificationQuery(queryOption);

    return _res;
  }

  ///同名チェック
  ///戻り値：true=同名あり／false=同名なし
  Future<bool> checkSameClassificationName(String name) async {
    //条件用のクラスの作成
    ClassificationQueryOption queryOption = ClassificationQueryOption(
        conditions: [ClassificationMasterConstants.name],
        conditionValues: [name]);

    //取得
    List<ClassificationDto> result =
        await classificationDao.classificationQuery(queryOption);

    //結果が1つでもあればtrue、0件ならfalse
    return result.length == 0 ? false : true;
  }

  ///ClassificationModelからINSERTする
  Future<int> insertClassificationForModel(ClassificationModel model) async {
    String timeStamp = DateTimeCommon().createTimeStamp(DateTime.now());
    ClassificationDto dto = ClassificationDto(
        id: 0, //insertなので0固定
        name: model.name,
        deleted: model.deleted == false ? 0 : 1,
        createdDateTime: timeStamp,
        updatedDateTime: '');

    //INSERT
    int queryResult = await classificationDao.insertClassification(dto);
    return queryResult;
  }

  ///ClassificationModelの内容でUPDATEする
  Future<int> updateClassificationForModel(ClassificationModel model) async {
    String timeStamp = DateTimeCommon().createTimeStamp(DateTime.now());
    ClassificationDto dto = ClassificationDto(
        id: model.id,
        name: model.name,
        deleted: model.deleted == false ? 0 : 1,
        createdDateTime: '',
        updatedDateTime: timeStamp);

    //UPDATE
    int queryResult = await classificationDao.updateClassification(dto);
    return queryResult;
  }

  ///UPDATE
  Future<int> updateClassification(ClassificationDto dto) async {
    //UPDATE
    int queryResult = await classificationDao.updateClassification(dto);
    return queryResult;
  }

  ///IDでDELTE
  ///論理削除
  Future<int> deleteClassification(int id) async {
    //IDで取得する
    List<ClassificationDto> selectResult = await getClassificationForId(id);

    //更新後のDTO作成
    String timeStamp = DateTimeCommon().createTimeStamp(DateTime.now());
    ClassificationDto dto = ClassificationDto(
        id: selectResult[0].id,
        name: selectResult[0].name,
        deleted: 1, //削除なので1固定
        createdDateTime: '',
        updatedDateTime: timeStamp);

    //UPDATE
    int queryResult = await classificationDao.updateClassification(dto);
    return queryResult;
  }
}
