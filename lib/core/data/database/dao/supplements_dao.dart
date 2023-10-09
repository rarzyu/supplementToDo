import 'package:sqflite/sqflite.dart';
import 'package:supplement_to_do/core/data/database/dto/supplements_dto.dart';
import '../db_helper.dart';

///グローバル変数
const String tableName = 't_supplements';

///このクラスで使用している構造体
///
///supplementsQueryOption用
///- conditions：where句のカラム、「カラム名 = ?」で記述
///- isAnds：Andかどうか、True=And、False=OR
///- conditionValues：where句の値
///- sortColumns：ソート条件のカラム名
///- isASC：昇順かどうか、True=ASC、False=DESC
class SupplementsQueryOption {
  final List<String>? conditions;
  final List<bool>? isAnds;
  final List<dynamic>? conditionValues;
  final List<String>? sortColumns;
  final List<bool>? isASC;

  SupplementsQueryOption({
    this.conditions,
    this.isAnds,
    this.conditionValues,
    this.sortColumns,
    this.isASC,
  });
}

class SupplementsDao {
  final DBHelper dbHelper;

  SupplementsDao(this.dbHelper);

  ///INSERT
  Future<int> insertSupplements(SupplementsDto supplements) async {
    final db = await dbHelper.database;
    return await db.insert(tableName, supplements.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///SELECT ALL
  Future<List<SupplementsDto>> getAllSupplements() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('t_tasks');
    return List.generate(maps.length, (i) => SupplementsDto.fromMap(maps[i]));
  }

  ///SELECT 条件指定
  Future<List<Map<String, dynamic>>> supplementsQuery(
      SupplementsQueryOption option) async {
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

    return await db.query(tableName,
        columns: option.conditions,
        where: whereString,
        whereArgs: option.conditionValues,
        orderBy: orderByString);
  }

  ///UPDATE
  Future<int> updateSupplements(SupplementsDto supplements) async {
    final db = await dbHelper.database;
    return await db.update(tableName, supplements.toMap(),
        where: 'id = ?', whereArgs: [supplements.id]);
  }

  ///DELETE
  Future<int> deleteSupplements(int id) async {
    final db = await dbHelper.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
