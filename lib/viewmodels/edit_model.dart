import 'package:flutter/material.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/utils/dbhelper.dart';

class EditModel extends ChangeNotifier {
  List<String> markets = ["NYSE", "NASDAQ"];
  String _dropdownValue = "NYSE";
  String get dropdownValue => _dropdownValue;

  String stockName = '';
  String stockTicker = '';
  String stockMarket = '';
  String stockMemo = '';
  String stockCreatedAt = DateTime.now().toString();
  String stockUpdatedAt = DateTime.now().toString();

  bool isLoading = false;

  final dbhelp = DatabaseHelper();

  onChanged(String newValue) {
    _dropdownValue = newValue;
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
    StockMemo newMemo = StockMemo(
      stockName,
      stockTicker,
      _dropdownValue,
      stockMemo,
      stockCreatedAt,
      stockUpdatedAt,
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

    stockCreatedAt = memo.createdAt;
    stockUpdatedAt = DateTime.now().toString();

    StockMemo changeMemo = StockMemo.withId(
      memo.id,
      stockName,
      stockTicker,
      stockMarket,
      stockMemo,
      stockCreatedAt,
      stockUpdatedAt,
    );

    if (memo.id != null) {
      final document = await dbhelp.updateMemo(changeMemo);
      print(document);
    } else {
      throw ('IDなし');
    }
  }
}
