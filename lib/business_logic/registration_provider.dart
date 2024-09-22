import 'package:flutter/material.dart';

class RegistrationProvider with ChangeNotifier {
  String _status = 'a';

  String get status => _status;

  void updateStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }
}
