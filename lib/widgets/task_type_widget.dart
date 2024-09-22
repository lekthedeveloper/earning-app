import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget taskType({
  String? title,
  String? subTitle,
  String? icon,
  int? bottomPadding = 0,
  String? pointSystem,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 23.w, top: 10.h),
    child: Container(
      height: 45.h,
      width: 315.w,
      decoration: BoxDecoration(
          color: const Color(0xffE9F5F2),
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3,
                spreadRadius: 2,
                offset: const Offset(0, 5)),
          ]),
      child: Row(
        children: [
          Container(
            height: 45.h,
            width: 240.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.h, bottom: bottomPadding!.h),
                  child: SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: Image.asset('assets/icons/$icon')),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        title!,
                        style: TextStyle(
                            fontFamily: 'Otoma',
                            color: const Color(0xff23413A),
                            fontSize: 10.sp),
                      ),
                      Text(
                        subTitle!,
                        style:
                            TextStyle(fontFamily: 'OpenSans', fontSize: 7.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset('assets/icons/coin.png')),
                )
              ],
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            pointSystem!,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 9.sp,
            ),
          )
        ],
      ),
    ),
  );
}
