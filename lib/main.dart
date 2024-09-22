import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/ads_provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'package:social_forum/business_logic/profile_provider.dart';

import 'package:social_forum/business_logic/registration_provider.dart';

import 'package:social_forum/presentation/session_screen.dart';
import 'business_logic/bottom_navvigation_provider.dart';
import 'routing/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WalletProvider()),
          ChangeNotifierProvider(create: (context) => BottomNavProvider()),
          ChangeNotifierProvider(create: (context) => RegistrationProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(
              create: (context) => AuthProvider()..loadToken()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SessionScreen(),
          initialRoute: RouteManager.login,
          onGenerateRoute: RouteManager.generateRoute,
        );
      },
    );
  }
}
