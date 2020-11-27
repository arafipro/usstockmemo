import 'package:flutter/material.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/utils/dbhelper.dart';

class EditModel extends ChangeNotifier {
  List<String> markets = ["NYSE", "NASDAQ"];
  String dropdownValue = "NYSE";

  String stockName = '';
  String stockTicker = '';
  String stockMarket = 'NYSE';
  String stockMemo = '';
  // DateTime stockCreatedAt = DateTime.now();
  bool isLoading = false;

  final dbhelp = DatabaseHelper();

  onChanged(String newValue) {
    stockMarket = dropdownValue = newValue;
    // print(dropdownValue);
    notifyListeners();
  }

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addMemo() async {
    // 入力チェック
    // if (stockName.isEmpty) {
    //   throw ('Please input Stock Name');
    // }
    // if (stockTicker.isEmpty) {
    //   throw ('Please input Ticker');
    // }
    // if (stockMemo.isEmpty) {
    //   throw ('Please input Memo');
    // }
    StockMemo newMemo = StockMemo(
      stockName,
      stockTicker,
      stockMarket,
      stockMemo,
      // stockCreatedAt,
    );
    await dbhelp.insertMemo(newMemo);
  }

  Future updateMemo(StockMemo memo) async {
    // if (memoName.isEmpty && memoAge.isEmpty) {
    //   throw ('変更なし');
    // }

    // stockNameが変更されない場合は元の値を代入
    stockName.isEmpty ? stockName = memo.name : null;

    // stockTickerが変更されない場合は元の値を代入
    stockTicker.isEmpty ? stockTicker = memo.ticker : null;

    // stockMarketが変更されない場合は元の値を代入
    stockMarket.isEmpty ? stockMarket = memo.market : null;

    // stockMemoが変更されない場合は元の値を代入
    stockMemo.isEmpty ? stockMemo = memo.memo : null;

    // print('changed name:$memoName'); // 変更後の値
    // print('changed age:$memoAge'); // 変更後の値
    // print('id:${memo.id}');
    StockMemo changeMemo = StockMemo.withId(
      memo.id,
      stockName,
      stockTicker,
      stockMarket,
      stockMemo,
    );

    if (memo.id != null) {
      final document = await dbhelp.updateMemo(changeMemo);
      print(document);
    } else {
      throw ('IDなし');
    }
  }
}
