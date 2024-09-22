// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final String hint;
  final String iconName;
  final int hintFontSize;
  bool showObscure;
  bool showObsucureFunction;
  final TextEditingController controller;
  bool togglePassword;
  CustomTextFormField(
      {super.key,
      required this.title,
      required this.hint,
      required this.iconName,
      this.showObscure = false,
      required this.controller,
      this.togglePassword = false,
      this.showObsucureFunction = false,
      this.hintFontSize = 10});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 260.w,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff656865),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 50.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                      height: 16.h,
                      width: 16.w,
                      child: Image.asset('assets/icons/${widget.iconName}')),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10.sp,
                        color: const Color(0xff959595)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
              width: 140.w,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.showObscure,
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      color: Colors.grey),
                  decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: widget.hintFontSize.sp,
                          color: const Color(0xffC4C4C4)),
                      border: InputBorder.none),
                ),
              )),
          Visibility(
            visible: widget.showObsucureFunction,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.togglePassword = !widget.togglePassword;
                  widget.showObscure = !widget.showObscure;
                });
              },
              child: SizedBox(
                height: 15.h,
                width: 15.w,
                child: Image.asset(widget.togglePassword == false
                    ? 'assets/icons/view.png'
                    : 'assets/icons/hide.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
