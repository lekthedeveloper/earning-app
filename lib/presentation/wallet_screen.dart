import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Icon(
              Icons.arrow_back,
              color: const Color(0xff23413A),
              size: 30.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Center(
            child: Text(
              'Total Points',
              style: TextStyle(
                  fontFamily: 'Otoma',
                  fontSize: 30.sp,
                  color: const Color(0xff23413A)),
            ),
          ),
          Center(
            child: Text(
              '156',
              style: TextStyle(
                  fontFamily: 'Otoma',
                  fontSize: 50.sp,
                  color: const Color(0xff009F06)),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              'Minimum withdrawal- \$50',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 8.sp,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                  width: 260.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      color: const Color(0xff23413A),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.grey.shade300,
                            spreadRadius: 2)
                      ]),
                  child: Center(
                    child: Text(
                      'Withdraw',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontSize: 12.sp),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: Container(
              height: 100.h,
              width: 320.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4)),
                  ]),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                    child: Text(
                      'Total\nCompleted\nTask',
                      style: TextStyle(
                          fontFamily: 'Otoma',
                          fontSize: 8.sp,
                          color: const Color(0xff23413A)),
                    ),
                  ),
                  Container(
                    height: 30.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      '47',
                      style: TextStyle(
                          fontFamily: 'Otoma',
                          fontSize: 12.sp,
                          color: Colors.grey.withOpacity(0.9)),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                    child: Text(
                      'Total\nCompleted',
                      style: TextStyle(
                          fontFamily: 'Otoma',
                          fontSize: 8.sp,
                          color: const Color(0xff23413A)),
                    ),
                  ),
                  Container(
                    height: 30.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      '\$120.87',
                      style: TextStyle(
                          fontFamily: 'Otoma',
                          fontSize: 10.sp,
                          color: const Color(0xff23413A)),
                    )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              'Withdraw History',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 8.sp,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
