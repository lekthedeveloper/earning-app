import 'package:flutter/material.dart';
import '../models/sql_database.dart';

class WalletProvider with ChangeNotifier {
  double totalEarning = 0;
  bool weekDayisTap = false;
  int spins = 0;
  double earnedValue = 0;
  String spinDate = '';
  String checkInDate = '';

  WalletProvider() {
    _loadTotalEarnings();
    _loadSpinData();
    _loadCheckInData();
  }

  Future<void> _loadTotalEarnings() async {
    totalEarning = await DatabaseHelper().getTotalEarnings();
    notifyListeners();
  }

  Future<void> _loadSpinData() async {
    spins = await DatabaseHelper().getSpinCount();
    spinDate = await DatabaseHelper().getSpinDate();
    notifyListeners();
  }

  clearEarning() {
    totalEarning = 0;
    notifyListeners();
  }

  Future<void> _loadCheckInData() async {
    weekDayisTap = await DatabaseHelper().getWeekDayisTap();
    checkInDate = await DatabaseHelper().getCheckInDate();
    notifyListeners();
  }

  Future<void> updateWallet(double newBalance) async {
    totalEarning = newBalance;
    await DatabaseHelper().updateTotalEarnings(totalEarning);
    notifyListeners();
  }

  Future<void> dailyCheck(String todayDate) async {
    totalEarning += 30;
    await DatabaseHelper().updateTotalEarnings(totalEarning);
    await updateWeekDayisTap(true, todayDate);
    notifyListeners();
  }

  Future<void> videoEarning() async {
    totalEarning += 30;
    await DatabaseHelper().updateTotalEarnings(totalEarning);
    notifyListeners();
  }

  Future<void> updateWeekDayisTap(bool weekDayisTap, String checkInDate) async {
    this.weekDayisTap = weekDayisTap;
    this.checkInDate = checkInDate;
    await DatabaseHelper().updateWeekDayisTap(weekDayisTap, checkInDate);
    notifyListeners();
  }

  Future<void> updateSpinCount(int newSpinCount, String spinDate) async {
    spins = newSpinCount;
    this.spinDate = spinDate;
    await DatabaseHelper().updateSpinData(newSpinCount, spinDate);
    notifyListeners();
  }

  String get wallet {
    return totalEarning.floor().toString();
  }
}
