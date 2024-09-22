import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'package:social_forum/presentation/ads_screen.dart';
import 'package:social_forum/presentation/login_screen.dart';
import 'package:social_forum/presentation/profile_screen.dart';
import 'package:social_forum/presentation/task_screen.dart';
import 'package:social_forum/presentation/wallet_screen.dart';
import 'package:social_forum/widgets/custom_navigation_observers.dart';

import '../business_logic/bottom_navvigation_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final bottomNavigationIndexController = [
    RebuildWidget(
        builder: (context, key) {
          return const AdsScreen();
        },
        refreshInterval: const Duration(seconds: 1)),
    const TaskScreen(),
    const WalletScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.sessionToken.isEmpty) {
          Future.microtask(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen())));
        }

        return Consumer<BottomNavProvider>(
          builder: (context, value, child) => Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: const Duration(milliseconds: 500),
                child: bottomNavigationIndexController[value.index]),
            bottomNavigationBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Container(
                height: 80.h, // Set the same height here
                color: const Color(0xff23413A),
                child: BottomNavigationBar(
                    backgroundColor: const Color(0xff23413A),
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle:
                        TextStyle(fontFamily: 'Poppins', fontSize: 11.sp),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: 'Poppins', fontSize: 11.sp),
                    selectedItemColor: const Color(0xff407CE2),
                    unselectedItemColor: Colors.grey[700],
                    showUnselectedLabels: false,
                    currentIndex: value.index,
                    showSelectedLabels: false,
                    onTap: (index) {
                      value.changeIndex(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                          backgroundColor: const Color(0xff23413A),
                          activeIcon: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child:
                                  Image.asset('assets/icons/homeactive.png')),
                          label: '',
                          icon: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: Image.asset('assets/icons/home.png'))),
                      BottomNavigationBarItem(
                        label: '',
                        backgroundColor: const Color(0xff23413A),
                        activeIcon: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.asset('assets/icons/taskactive.png')),
                        icon: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.asset('assets/icons/task.png')),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: const Color(0xff23413A),
                        activeIcon: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child:
                                Image.asset('assets/icons/walletactive.png')),
                        label: '',
                        icon: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.asset('assets/icons/wallet.png')),
                      ),
                      BottomNavigationBarItem(
                          backgroundColor: const Color(0xff23413A),
                          label: '',
                          activeIcon: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: Image.asset(
                                  'assets/icons/accountactive.png')),
                          icon: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: Image.asset('assets/icons/account.png')))
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
