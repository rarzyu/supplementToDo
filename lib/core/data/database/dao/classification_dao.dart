import 'package:supplement_to_do/config/constants/db/classification_master_constants.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';
import '../dto/classification_dto.dart';

///このクラスで使用している構造体
///
///classificationQuery用
///- conditions：where句のカラム
///- isAnds：Andかどうか、True=And、False=OR
///- conditionValues：where句の値
///- sortColumns：ソート条件のカラム名
///- isASC：昇順かどうか、True=ASC、False=DESC
class ClassificationQueryOption {
  final List<String>? conditions;
  final List<bool>? isAnds;
  final List<dynamic>? conditionValues;
  final List<String>? sortColumns;
  final List<bool>? isASC;

  ClassificationQueryOption({
    this.conditions,
    this.isAnds,
    this.conditionValues,
    this.sortColumns,
    this.isASC,
  });
}

///m_classification 分類管理マスタのDBヘルパークラス
class ClassificationDao {
  final DBHelper dbHelper;

  ClassificationDao(this.dbHelper);

  ///INSERT
  Future<int> insertClassification(ClassificationDto classification) async {
    final db = await dbHelper.database;
    return await db.insert(
        ClassificationMasterConstants.tableName, classification.toMapNoId());
  }

  ///SELECT ALL
  Future<List<ClassificationDto>> getClassificationAll() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(ClassificationMasterConstants.tableName);
    return List.generate(
        maps.length, (i) => ClassificationDto.fromMap(maps[i]));
  }

  ///SELECT 条件指定
  Future<List<ClassificationDto>> classificationQuery(
      ClassificationQueryOption option) async {
    final db = await dbHelper.database;
    String whereString = ''; //where句
    String orderByString = ''; //order by句

    //where句の生成
    //nullでない、かつ、要素数がオペレーター+1とカラム数で一致すること
    if (option.isAnds == null && option.conditions?.length == 1) {
      //AndsがNullでWhere句のカラムが１つなら
      whereString += option.conditions![0] + ' = ?'; //where句のカラム名
    } else {
      if (option.conditions != null &&
          option.isAnds != null &&
          option.conditions!.length == option.isAnds!.length + 1) {
        for (int i = 0; i < option.conditions!.length; i++) {
          whereString += option.conditions![i] + ' = ?'; //where句のカラム名
          if (i < option.isAnds!.length) {
            whereString +=
                option.isAnds![i] ? ' AND ' : ' OR '; //フラグでANDとORを切り替え
          }
        }
      }
    }

    //order by句の生成
    //nullでない、かつ、要素数がオペレーター+1とカラム数で一致すること
    if (option.sortColumns != null &&
        option.isASC != null &&
        option.sortColumns!.length == option.isASC!.length) {
      for (var i = 0; i < option.sortColumns!.length; i++) {
        orderByString += option.sortColumns![i];
        orderByString += option.isASC![i] ? ' ASC' : ' DESC';
        if (i != option.sortColumns!.length - 1) {
          orderByString += ',';
        }
      }
    }

    final List<Map<String, dynamic>> maps = await db.query(
        ClassificationMasterConstants.tableName,
        where: whereString,
        whereArgs: option.conditionValues,
        orderBy: orderByString == '' ? null : orderByString);

    return List.generate(
        maps.length, (i) => ClassificationDto.fromMap(maps[i]));
  }

  ///UPDATE
  Future<int> updateClassification(ClassificationDto classification) async {
    final db = await dbHelper.database;
    return await db.update(
      ClassificationMasterConstants.tableName,
      classification.toMapNoCreatedDateTime(),
      where: '${ClassificationMasterConstants.id} = ?',
      whereArgs: [classification.id],
    );
  }

  ///DELETE
  Future<int> deleteClassification(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      ClassificationMasterConstants.tableName,
      where: '${ClassificationMasterConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
