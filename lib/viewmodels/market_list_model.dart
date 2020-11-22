import 'package:flutter/material.dart';

class MarketListModel extends ChangeNotifier {
  List<String> markets = ["NYSE", "NASDAQ"];
  String dropdownValue = "NYSE";

  onChanged(String newValue) {
    dropdownValue = newValue;
    print(dropdownValue);
    notifyListeners();
  }
}
