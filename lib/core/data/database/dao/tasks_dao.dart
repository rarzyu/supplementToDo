import 'package:sqflite/sqflite.dart';
import 'package:supplement_to_do/config/constants/db/tasks_table_constants.dart';
import '../db_helper.dart';
import '../dto/tasks_dto.dart';

///このクラスで使用している構造体
///
///tasksQueryOption用
///- conditions：where句のカラム、「カラム名 = ?」で記述
///- isAnds：Andかどうか、True=And、False=OR
///- conditionValues：where句の値
///- sortColumns：ソート条件のカラム名
///- isASC：昇順かどうか、True=ASC、False=DESC
class TasksQueryOption {
  final List<String>? conditions;
  final List<bool>? isAnds;
  final List<dynamic>? conditionValues;
  final List<String>? sortColumns;
  final List<bool>? isASC;

  TasksQueryOption({
    this.conditions,
    this.isAnds,
    this.conditionValues,
    this.sortColumns,
    this.isASC,
  });
}

class TasksDao {
  final DBHelper dbHelper;

  TasksDao(this.dbHelper);

  ///INSERT
  Future<int> insertTasks(TasksDto tasks) async {
    final db = await dbHelper.database;
    return await db.insert(TasksTableConstants.tableName, tasks.toMapNoId(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///SELECT ALL
  Future<List<TasksDto>> getAllTasks() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(TasksTableConstants.tableName);
    return List.generate(maps.length, (i) => TasksDto.fromMap(maps[i]));
  }

  ///SELECT 条件指定
  Future<List<TasksDto>> tasksQuery(TasksQueryOption option) async {
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
        TasksTableConstants.tableName,
        where: whereString,
        whereArgs: option.conditionValues,
        orderBy: orderByString == '' ? null : orderByString);

    return List.generate(maps.length, (i) => TasksDto.fromMap(maps[i]));
  }

  ///UPDATE
  Future<int> updateTasks(TasksDto tasks) async {
    final db = await dbHelper.database;
    return await db.update(
        TasksTableConstants.tableName, tasks.toMapNoCreateDateTime(),
        where: '${TasksTableConstants.id} = ?', whereArgs: [tasks.id]);
  }

  ///DELETE
  Future<int> deleteTasks(int id) async {
    final db = await dbHelper.database;
    return await db.delete(TasksTableConstants.tableName,
        where: '${TasksTableConstants.id} = ?', whereArgs: [id]);
  }
}
