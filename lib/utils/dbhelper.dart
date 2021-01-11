import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:usstockmemo/models/stock_memo.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String memoTable = 'memo_table';    // テーブル名
  String colId = 'id';                // KEY
  String colName = 'name';            // 銘柄名
  String colTicker = 'ticker';        // ティッカー
  String colmarket = 'market';        // 市場
  String colMemo = 'memo';            // メモ
  String colCreatedAt = 'createdAt';  // 登録日時
  String colUpdatedAt = 'updatedAt';  // 更新日時

  DatabaseHelper._createInstance();
  // Named constructor to create instance of DatabaseHelper(DatabaseHelperのインスタンスを作成するための名前付きコンストラクター)

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object(これは一度だけ実行されます、シングルトンオブジェクト)
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'stockmemos.db';

    // Open/create the database at a given path
    var memosDatabase = await openDatabase(path,
        version: 3, onCreate: _createDb, onUpgrade: _upgradeDb);
    return memosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    // sql文は大文字ではなく小文字で記述しないとエラーになるよう（なぜかはわからない）
    await db.execute(
        """create table $memoTable($colId integer primary key autoincrement, $colName text,
          $colTicker text, $colmarket text, $colMemo text""");
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    var scripts = {
      '2': ['ALTER TABLE $memoTable ADD COLUMN $colCreatedAt TIMESTAMP;'],
      '3': ['ALTER TABLE $memoTable ADD COLUMN $colUpdatedAt TIMESTAMP;'],
    };
    for (var i = oldVersion + 1; i <= newVersion; i++) {
      var queries = scripts[i.toString()];
      for (String query in queries) {
        await db.execute(query);
      }
    }
  }

  // Fetch Operation: Get all Memo objects from database
  Future<List<Map<String, dynamic>>> getMemoMapList() async {
    Database db = await this.database;
    var result =
        // await db.rawQuery('select * from $memoTable order by $colRecordedAt asc');
        await db.rawQuery('select * from $memoTable');
    return result;
  }

  // Insert Operation: Insert a Memo object to database
  Future<int> insertMemo(StockMemo memo) async {
    Database db = await this.database;
    var result = await db.insert(memoTable, memo.toMap());
    return result;
  }

  // Update Operation: Update a Memo object and save it to database
  Future<int> updateMemo(StockMemo memo) async {
    var db = await this.database;
    var result = await db.update(memoTable, memo.toMap(),
        where: '$colId = ?', whereArgs: [memo.id]);
    return result;
  }

  // Delete Operation: Delete a Memo object from database
  Future<int> deleteMemo(int id) async {
    var db = await this.database;
    int result =
        // await db.rawDelete('delete from $memoTable where $colId = $id');
        await db.delete(memoTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Memo List' [ List<Dog> ]
  Future<List<StockMemo>> getMemoList() async {
    var memoMapList = await getMemoMapList(); // Get 'Map List' from database
    int count =
        memoMapList.length; // Count the number of map entries in db table

    List<StockMemo> memoList = List<StockMemo>();
    // For loop to create a 'Memo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      memoList.add(StockMemo.fromMapObject(memoMapList[i]));
    }

    return memoList;
  }
}
