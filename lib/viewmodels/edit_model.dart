import 'package:flutter/material.dart';

class EditModel extends ChangeNotifier {
  List<String> markets = ["NYSE", "NASDAQ"];
  String dropdownValue = "NYSE";

  onChanged(String newValue) {
    dropdownValue = newValue;
    print(dropdownValue);
    notifyListeners();
  }
}
