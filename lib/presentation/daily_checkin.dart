import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/ads_provider.dart';

class DailyCheckIn extends StatefulWidget {
  const DailyCheckIn({super.key});

  @override
  State<DailyCheckIn> createState() => _DailyCheckInState();
}

class _DailyCheckInState extends State<DailyCheckIn> {
  List<String> weekday = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  bool isCurrentDayMatched(String weekday) {
    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEEE').format(now); // Get full day name
    return currentDay == weekday;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff52449f),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h, left: 10.w, bottom: 20.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset('assets/icons/previous.png')),
                ),
                SizedBox(width: 40.w),
                Text(
                  'DAILY CHECK INS',
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 580.h,
            width: 330.w,
            child: Consumer<WalletProvider>(
              builder: (context, value, child) => ListView.separated(
                  itemBuilder: (context, index) {
                    DateTime now = DateTime.now();
                    DateTime? checkInDate;

                    try {
                      if (value.checkInDate.isNotEmpty) {
                        checkInDate = DateTime.parse(value.checkInDate);
                      }
                    } catch (e) {
                      debugPrint('Error parsing date: $e');
                      checkInDate = null;
                    }

                    return GestureDetector(
                      onTap: () {
                        if (isCurrentDayMatched(weekday[index])) {
                          if (value.weekDayisTap &&
                              checkInDate != null &&
                              isSameDate(checkInDate, now)) {
                            // Already checked in today
                            return;
                          } else {
                            // Update check-in status
                            value.dailyCheck(now.toIso8601String());
                          }
                        } else {
                          return;
                        }
                      },
                      child: (value.weekDayisTap &&
                              checkInDate != null &&
                              isSameDate(checkInDate, now))
                          ? Container(
                              height: 70.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xff6c5dc2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  weekday[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ),
                            )
                          : Container(
                              height: 70.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                  color: isCurrentDayMatched(weekday[index])
                                      ? const Color(0xff4ed6c2)
                                      : const Color(0xff6c5dc2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  weekday[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ),
                            ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                  itemCount: weekday.length),
            ),
          )
        ],
      ),
    );
  }
}
