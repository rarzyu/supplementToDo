import 'package:supplement_to_do/core/data/database/db_helper.dart';
import '../dto/classification_dto.dart';

///## グローバル変数
const String classificationMaster = 'm_classification';

///## このクラスで使用している構造体
///
///### classificationQuery用
///- conditions：where句のカラム、「カラム名 = ?」で記述
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

///## m_classification 分類管理マスタのDBヘルパークラス
class ClassificationDAO {
  final DBHelper dbHelper;

  ClassificationDAO(this.dbHelper);

  ///### INSERT
  Future<int> insertClassification(ClassificationModel classification) async {
    final db = await dbHelper.database;
    return await db.insert('m_classification', classification.toMap());
  }

  ///### SELECT
  ///#### ALL
  Future<List<ClassificationModel>> getClassificationAll() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('m_classification');
    return List.generate(
        maps.length, (i) => ClassificationModel.fromMap(maps[i]));
  }

  ///#### 条件指定
  Future<List<Map<String, dynamic>>> classificationQuery(
      ClassificationQueryOption option) async {
    final db = await dbHelper.database;
    String whereString = ''; //where句
    String orderByString = ''; //order by句

    //where句の生成
    //nullでない、かつ、要素数がオペレーター+1とカラム数で一致すること
    if (option.conditions != null &&
        option.isAnds != null &&
        option.conditions!.length == option.isAnds!.length + 1) {
      for (int i = 0; i < option.conditions!.length; i++) {
        whereString += option.conditions![i]; //where句のカラム名
        if (i < option.isAnds!.length) {
          whereString += option.isAnds![i] ? ' AND ' : ' OR '; //フラグでANDとORを切り替え
        }
      }
    }

    //order by句の生成
    //nullでない、かつ、要素数がオペレーター+1とカラム数で一致すること
    if (option.sortColumns != null &&
        option.isASC != null &&
        option.sortColumns!.length == option.isASC!.length + 1) {
      for (var i = 0; i < option.sortColumns!.length; i++) {
        orderByString += option.sortColumns![i];
        orderByString += option.isASC![i] ? ' ASC' : ' DESC';
      }
    }

    return await db.query(classificationMaster,
        columns: option.conditions,
        where: whereString,
        whereArgs: option.conditionValues,
        orderBy: orderByString);
  }

  ///### UPDATE
  Future<int> updateClassification(ClassificationModel classification) async {
    final db = await dbHelper.database;
    return await db.update(
      'm_classification',
      classification.toMap(),
      where: 'id = ?',
      whereArgs: [classification.id],
    );
  }

  ///### DELETE
  Future<int> deleteClassification(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'm_classification',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
