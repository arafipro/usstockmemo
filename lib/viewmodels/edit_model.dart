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
    StockMemo newMemo = StockMemo(
      stockName,
      stockTicker,
      stockMarket,
      stockMemo,
      // stockCreatedAt,
    );
    await dbhelp.insertMemo(newMemo);
  }
}
