import 'package:flutter/material.dart';

class ColorCounters extends ChangeNotifier {
  int redCount = 0;
  int blueCount = 0;

  void incrementRedCount() {
    redCount++;
    notifyListeners();
  }

  void incrementBlueCount(){
    blueCount++;
    notifyListeners();
  }
}
