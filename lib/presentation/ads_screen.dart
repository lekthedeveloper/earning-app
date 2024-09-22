import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'package:social_forum/business_logic/profile_provider.dart';
import 'package:social_forum/routing/navigation_controller.dart';
import 'package:social_forum/widgets/custom_progressbar.dart';
import 'package:social_forum/widgets/task_type_widget.dart';
import 'package:social_forum/widgets/underlined_text_widget.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  static const int initialCountdown = 10 * 60; // 5 minutes in seconds
  int _remainingTime = initialCountdown;
  int condition = 1;
  int adsindexId = 0;
  Timer? _timer;
  void startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          condition = 0;
        } else {
          timer.cancel();
          condition = 1;
        }
      });
    });
  }

  @override
  void initState() {
    context.read<AuthProvider>().getUserDetails(context);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String getFormattedTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString()}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = context.watch<ProfileProvider>();

    if (profileProvider.profile == null) {
      // Show a loading indicator while the profile data is being fetched
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        backgroundColor: const Color(0xffE9F5F2),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h, left: 15.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Hey ${profileProvider.profile!.username}',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontFamily: 'Otoma',
                          color: const Color(0xff23413A)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Image.asset('assets/icons/profile.png'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                'Ready to perform new task today?',
                style: TextStyle(fontFamily: 'OpenSans', fontSize: 9.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Container(
                height: 170.h,
                width: 320.w,
                decoration: BoxDecoration(
                    color: const Color(0xffE9F5F2),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 30.0,
                          color: Color.fromARGB(177, 195, 191, 191),
                          spreadRadius: 1),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Earning \nPerformance',
                              style: TextStyle(
                                  fontFamily: 'Otoma',
                                  fontSize: 15.sp,
                                  height: 1.3,
                                  color: const Color(0xff23413A)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h, right: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<ProfileProvider>(
                                  builder: (context, value, child) => Text(
                                    '${value.profile!.pointBalance} Pts',
                                    style: TextStyle(
                                        fontFamily: 'Otoma',
                                        color: const Color(0xff009F06),
                                        fontSize: 14.sp),
                                  ),
                                ),
                                Text(
                                  'My Point Balance:',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 6.sp,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 10.w),
                          child: Text(
                            'Today\'s tasks:',
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 8.sp),
                          ),
                        ),
                        const CustomProgressBar(value: 1, height: 20),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 25.h),
                      child: Row(
                        children: [
                          Text(
                            'Task \nCompleted',
                            style: TextStyle(
                                fontFamily: 'Otoma',
                                fontSize: 12.sp,
                                height: 1.3,
                                color: const Color(0xff23413A)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 5.w),
                            child: Container(
                              height: 35.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                '7/10',
                                style: TextStyle(
                                    fontFamily: 'Otoma',
                                    fontSize: 12.sp,
                                    color: const Color(0xff858585)),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Today\'s\nEarnings',
                            style: TextStyle(
                                fontFamily: 'Otoma',
                                fontSize: 11.sp,
                                height: 1.3,
                                color: const Color(0xff23413A)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 5.w),
                            child: Container(
                              height: 35.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                '60',
                                style: TextStyle(
                                    fontFamily: 'Otoma',
                                    fontSize: 12.sp,
                                    color: const Color(0xff23413A)),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w, top: 20.h),
              child: Text(
                'Earn Points',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 8.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w, top: 10.h),
              child: Row(
                children: [
                  Container(
                    height: 70.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xff23413A), width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color.fromARGB(177, 195, 191, 191),
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Image.asset('assets/icons/video.png'),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Watch Video Ads',
                            style: TextStyle(
                                fontFamily: 'Otoma',
                                fontSize: 6.sp,
                                color: const Color(0xff23413A)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xff23413A), width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color.fromARGB(177, 195, 191, 191),
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 50.h,
                              width: 50.w,
                              child: Image.asset('assets/icons/chess.png')),
                          Text(
                            'Engage & Earn',
                            style: TextStyle(
                                fontFamily: 'Otoma',
                                fontSize: 6.sp,
                                color: const Color(0xff23413A)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xff23413A), width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color.fromARGB(177, 195, 191, 191),
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteManager.wheel);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                                height: 50.h,
                                width: 50.w,
                                child: Image.asset('assets/icons/ship.png')),
                            Text(
                              'Wheel of Fortune',
                              style: TextStyle(
                                  fontFamily: 'Otoma',
                                  fontSize: 6.sp,
                                  color: const Color(0xff23413A)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    'Other Activites',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 8.sp,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                  ),
                  const CustomUnderlineText(
                      text: 'See More Activities',
                      fontSize: 8,
                      underlineColor: Color(0xff5196FE),
                      underlineThickness: 1,
                      underlineSpacing: 10)
                ],
              ),
            ),
            taskType(
                title: 'Complete Survey',
                subTitle: 'Win upto\$5',
                icon: 'survey.png',
                pointSystem: '45 Points/View'),
            taskType(
                title: 'Refer Friends',
                subTitle: 'Earn by referring your friends',
                icon: 'users.png',
                pointSystem: '45 Points/Ref'),
            taskType(
                title: 'Watch Live Streams',
                subTitle: 'Win upto\$5',
                icon: 'videoicon.png',
                bottomPadding: 5,
                pointSystem: '45 Points/Mins'),
          ],
        ));
  }
}
