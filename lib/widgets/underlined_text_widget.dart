import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUnderlineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color underlineColor;
  final double underlineThickness;
  final double underlineSpacing;

  const CustomUnderlineText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.underlineColor,
    required this.underlineThickness,
    required this.underlineSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: const Color(0xff5196FE),
            fontSize: fontSize.sp,
            decoration: TextDecoration.underline,
          ),
        ),
        Positioned(
          bottom: -underlineSpacing,
          child: Container(
            width: text.length * fontSize * 0.5, // Adjust this factor if needed
            height: underlineThickness,
            color: const Color(0xff5196FE),
          ),
        ),
      ],
    );
  }
}
