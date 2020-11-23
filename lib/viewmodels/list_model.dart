import 'package:flutter/material.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/utils/dbhelper.dart';

class ListModel extends ChangeNotifier {
  List<StockMemo> memos = [];
  // DatabaseHelper dbhelp;ではなく下記通りにする
  final dbhelp = DatabaseHelper();

  Future fetchMemos() async {
    final memos = await dbhelp.getMemoList();
    this.memos = memos;
    notifyListeners();
  }

  Future deleteMemo(StockMemo memo) async {
    await dbhelp.deleteMemo(memo.id);
  }
}
