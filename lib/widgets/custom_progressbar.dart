import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final double height;

  const CustomProgressBar(
      {super.key, required this.value, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 220.w,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            child: Stack(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: value),
                  duration: const Duration(seconds: 1),
                  builder: (context, animatedValue, child) {
                    return Container(
                      width: (animatedValue * 250).clamp(0,
                          250), // Ensuring the width doesn't exceed the border width
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Color(0xff18EF48),
                          ],
                          stops: [0.0, 0.33, 0.66, 1.0],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: (value * 250).clamp(0, 260), // Adjust the position as needed
          bottom: -15, // Adjust the position as needed
          child: const Icon(
            Icons.arrow_drop_up,
            size: 20,
          ),
        ),
      ],
    );
  }
}
