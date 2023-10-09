import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //データベース名とバージョン
  static final _dbName = 'sapplement_to_do_app.db';
  static final _dbVersion = 1;

  //テーブル名
  static final classificationMaster = 'm_classification';
  static final supplementsTable = 't_supplements';
  static final tasksTable = 't_tasks';

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
    //データベースを開く、存在しない場合は_onCreateを呼んでデータベースを作成
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  //テーブルの作成
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $classificationMaster (
        "id"	INTEGER,
        "name"	TEXT,
        "deleted"	INTEGER,
        "created_date_time"	TEXT,
        "updated_date_time"	TEXT,
        PRIMARY KEY("id" AUTOINCREMENT)
      )
    ''');

    await db.execute('''
        CREATE TABLE $supplementsTable (
          "id"	INTEGER,
          "name"	TEXT,
          "classification_id"	INTEGER,
          "created_date_time"	TEXT,
          "updated_date_time"	TEXT,
          FOREIGN KEY("classification_id") REFERENCES "m_classification"("id"),
          PRIMARY KEY("id" AUTOINCREMENT)
        )
    ''');

    await db.execute('''
        CREATE TABLE $tasksTable (
          "id"	INTEGER,
          "supplement_id"	INTEGER,
          "scheduled_date"	TEXT,
          "scheduled_time"	TEXT,
          "details"	TEXT,
          "completed"	INTEGER,
          "created_date_time"	TEXT,
          "updated_date_time"	TEXT,
          FOREIGN KEY("sapplement_id") REFERENCES "t_supplements"("id"),
          PRIMARY KEY("id" AUTOINCREMENT)
        )
    ''');
  }
}
