import 'package:sqflite/sqflite.dart';
import 'package:supplement_to_do/config/constants/db/repeats_table_constants.dart';
import 'package:supplement_to_do/core/data/database/dto/repeats_dto.dart';
import '../db_helper.dart';

///グローバル変数
const String tableName = 't_repeats';

///このクラスで使用している構造体
///
///repeatQueryOption用
///- conditions：where句のカラム、「カラム名 = ?」で記述
///- isAnds：Andかどうか、True=And、False=OR
///- conditionValues：where句の値
///- sortColumns：ソート条件のカラム名
///- isASC：昇順かどうか、True=ASC、False=DESC
class RepeatsQueryOption {
  final List<String>? conditions;
  final List<bool>? isAnds;
  final List<dynamic>? conditionValues;
  final List<String>? sortColumns;
  final List<bool>? isASC;

  RepeatsQueryOption({
    this.conditions,
    this.isAnds,
    this.conditionValues,
    this.sortColumns,
    this.isASC,
  });
}

class RepeatsDao {
  final DBHelper dbHelper;

  RepeatsDao(this.dbHelper);

  ///INSERT
  Future<int> insertRepeats(RepeatsDto repeats) async {
    final db = await dbHelper.database;
    return await db.insert(tableName, repeats.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///SELECT ALL
  Future<List<RepeatsDto>> getAllRepeats() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => RepeatsDto.fromMap(maps[i]));
  }

  ///SELECT 条件指定
  Future<List<Map<String, dynamic>>> repeatsQuery(
      RepeatsQueryOption option) async {
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
  Future<int> updateRepeats(RepeatsDto repeats) async {
    final db = await dbHelper.database;
    return await db.update(tableName, repeats.toMap(),
        where: RepeatsTableConstants.id + ' = ?', whereArgs: [repeats.id]);
  }

  ///DELETE
  Future<int> deleteRepeats(int id) async {
    final db = await dbHelper.database;
    return await db.delete(tableName,
        where: RepeatsTableConstants.id + ' = ?', whereArgs: [id]);
  }
}
