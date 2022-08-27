import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _myCounter = 0;

  get myValue => _myCounter;
  void add() {
    _myCounter++;
    notifyListeners();
  }
}
