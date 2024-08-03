import 'package:flutter/material.dart';

class TempProvider extends ChangeNotifier {
  int index = 0;
  List<double> temp = [
    20,
    20,
    20,
    20,
    20
  ];

  void changetemp(double newtemp, int currindex) {
    temp[currindex] = newtemp;
    notifyListeners();
  }

  void changeindex(int currindex) {
    index = currindex;
    notifyListeners();
  }
}
