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
    // stockNameが変更されない場合は元の値を代入
    if (stockName.isEmpty) {
      stockName = memo.name;
    }
    // stockTickerが変更されない場合は元の値を代入
    if (stockTicker.isEmpty) {
      stockTicker = memo.ticker;
    }
    // stockMarketが変更されない場合は元の値を代入
    if (stockMarket.isEmpty) {
      stockMarket = memo.market;
    }
    // stockMemoが変更されない場合は元の値を代入
    if (stockMemo.isEmpty) {
      stockMemo = memo.memo;
    }

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
