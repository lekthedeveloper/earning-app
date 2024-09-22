// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:social_forum/presentation/daily_checkin.dart';
import 'package:social_forum/presentation/dashboard.dart';
import 'package:social_forum/presentation/edit_profile.dart';
import 'package:social_forum/presentation/fortune_wheel.dart';
import 'package:social_forum/presentation/login_screen.dart';
import 'package:social_forum/presentation/verfiy_account.dart';

class RouteManager {
  static const String login = '/';
  static const String wheel = '/fortuneWheel';
  static const String dashboard = '/dashboard';
  static const String checkin = '/sdailycheck';
  static const String verfifyAccount = '/verifyaccount';
  static const String editProfile = '/editProfile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic valuePassed;
    if (settings.arguments != null) {
      valuePassed = settings.arguments as Map<String, dynamic>;
    }
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case wheel:
        return MaterialPageRoute(builder: (context) => const FortuneWheel());
      case checkin:
        return MaterialPageRoute(builder: (context) => const DailyCheckIn());
      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case verfifyAccount:
        return MaterialPageRoute(
            builder: (context) => VerfiyAccount(
                  email: valuePassed['email'],
                ));
      case editProfile:
        return MaterialPageRoute(
            builder: (context) => EditProfileScreen(
                  fullName: valuePassed['fullName'],
                  username: valuePassed['username'],
                  email: valuePassed['email'],
                  pasword: valuePassed['password'],
                ));

      default:
        throw const FormatException('you have not added this route yet');
    }
  }
}
