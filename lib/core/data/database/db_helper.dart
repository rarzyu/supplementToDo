import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supplement_to_do/config/constants/db/classification_master_constants.dart';
import 'package:supplement_to_do/config/constants/db/repeats_table_constants.dart';
import 'package:supplement_to_do/config/constants/db/supplements_table_constants.dart';
import 'package:supplement_to_do/config/constants/db/tasks_table_constants.dart';

class DBHelper {
  //データベース名とバージョン
  static const _dbName = 'sapplement_to_do_app.db';
  static const _dbVersion = 1;

  //シングルトンインスタンス
  //アプリケーション全体で1つのDBHelperインスタンスのみが存在するようにするための設計
  static DBHelper? _instance;
  static late Database _database;

  //プライベートな名前付きコンストラクタ
  //シングルトンパターンを実装するために、外部からインスタンスを作成できないようにする
  DBHelper._privateConstructor();

  //インスタンスを返すゲッター
  static DBHelper get instance {
    return _instance ??= DBHelper._privateConstructor();
  }

  //データベースへの参照を返すゲッター
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  //データベースの初期化
  _initDatabase() async {
    //ドキュメントディレクトリの取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    print('DBPath: $path');
    //データベースを開く、存在しない場合は_onCreateを呼んでデータベースを作成
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  //テーブルの作成
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${ClassificationMasterConstants.tableName} (
        ${ClassificationMasterConstants.id}	INTEGER,
        ${ClassificationMasterConstants.name}	TEXT,
        ${ClassificationMasterConstants.deleted}	INTEGER,
        ${ClassificationMasterConstants.createdDateTime}	TEXT,
        ${ClassificationMasterConstants.updatedDateTime}	TEXT,
        PRIMARY KEY(${ClassificationMasterConstants.id} AUTOINCREMENT)
      )
    ''');

    await db.execute('''
        CREATE TABLE ${SupplementsTableConstants.tableName} (
          ${SupplementsTableConstants.id}	INTEGER,
          ${SupplementsTableConstants.supplementName}	TEXT,
          ${SupplementsTableConstants.classificationId}	INTEGER,
          ${SupplementsTableConstants.createdDateTime}	TEXT,
          ${SupplementsTableConstants.updatedDateTime}	TEXT,
          PRIMARY KEY(${SupplementsTableConstants.id} AUTOINCREMENT)
        )
    ''');

    await db.execute('''
        CREATE TABLE ${TasksTableConstants.tableName} (
          ${TasksTableConstants.id}	INTEGER,
          ${TasksTableConstants.supplementId}	INTEGER,
          ${TasksTableConstants.scheduledDate}	TEXT,
          ${TasksTableConstants.scheduledTime}	TEXT,
          ${TasksTableConstants.repeatId} INTEGER,
          ${TasksTableConstants.details}	TEXT,
          ${TasksTableConstants.completed}	INTEGER,
          ${TasksTableConstants.createdDateTime}	TEXT,
          ${TasksTableConstants.updatedDateTime}	TEXT,
          PRIMARY KEY(${TasksTableConstants.id} AUTOINCREMENT)
        )
    ''');

    await db.execute('''
        CREATE TABLE ${RepeatsTableConstants.tableName} (
          ${RepeatsTableConstants.id}	INTEGER,
          ${RepeatsTableConstants.repeatCode}	INTEGER,
          ${RepeatsTableConstants.repeatTitle} TEXT,
          ${RepeatsTableConstants.dayOfWeek}	TEXT,
          ${RepeatsTableConstants.interval} INTEGER,
          ${RepeatsTableConstants.createdDateTime}	TEXT,
          ${RepeatsTableConstants.updatedDateTime}	TEXT,
          PRIMARY KEY(${RepeatsTableConstants.id} AUTOINCREMENT)
        )
    ''');
  }
}
