import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int index = 0;
  changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  resetIndex() {
    index = 0;
    debugPrint('index changed');
    notifyListeners();
  }
}
