import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_forum/models/verify_email_model.dart';

class VerfiyAccount extends StatefulWidget {
  final String email;
  const VerfiyAccount({super.key, required this.email});

  @override
  State<VerfiyAccount> createState() => _VerfiyAccountState();
}

class _VerfiyAccountState extends State<VerfiyAccount> {
  final FocusNode _focusNode_1 = FocusNode();
  final FocusNode _focusNode_2 = FocusNode();
  final FocusNode _focusNode_3 = FocusNode();
  final FocusNode _focusNode_4 = FocusNode();
  final input_1 = TextEditingController();
  final input_2 = TextEditingController();
  final input_3 = TextEditingController();
  final input_4 = TextEditingController();
  bool _isFocusNode_1 = false;
  bool _isFocusNode_2 = false;
  bool _isFocusNode_3 = false;
  bool _isFocusNode_4 = false;
  bool trigger = true;
  bool otp = false;
  void _onPinChanged(String value, FocusNode? nextFocusNode) {
    if (value.length == 1 && nextFocusNode != null) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    } else if (value.isEmpty && nextFocusNode == null) {
      _focusNode_4.unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  triggerError() {
    setState(() {
      trigger = false;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        trigger = true;
      });
    });
  }

  resendotp() {
    setState(() {
      otp = true;
    });
  }

  void _onFocusChange1() {
    setState(() {
      _isFocusNode_1 = _focusNode_1.hasFocus;
    });
  }

  void _onFocusChange2() {
    setState(() {
      _isFocusNode_2 = _focusNode_2.hasFocus;
    });
  }

  void _onFocusChange3() {
    setState(() {
      _isFocusNode_3 = _focusNode_3.hasFocus;
    });
  }

  void _onFocusChange4() {
    setState(() {
      _isFocusNode_4 = _focusNode_4.hasFocus;
    });
  }

  @override
  void initState() {
    _focusNode_1.addListener(_onFocusChange1);
    _focusNode_2.addListener(_onFocusChange2);
    _focusNode_3.addListener(_onFocusChange3);
    _focusNode_4.addListener(_onFocusChange4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 180.h, bottom: 30.h),
              child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: Image.asset('assets/icons/verify.png')),
            ),
            Text(
              'Enter code',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'A code was sent to',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  color: const Color(0xff656865)),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              widget.email,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  color: const Color(0xff656865)),
            ),
            SizedBox(
              height: 6.h,
            ),
            Visibility(
              visible: otp,
              child: Text('Invalid verification code ',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      color: Colors.red)),
            ),
            Visibility(
              visible: otp,
              child: SizedBox(
                height: 5.h,
              ),
            ),
            Visibility(
              visible: otp,
              child: GestureDetector(
                onTap: () {
                  resendOtp(widget.email);
                },
                child: Text('Click here to resend email',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff23413A))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 60.w),
              child: ShakingRow(
                condition: trigger, // Change this to true or false to test
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: input_1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      focusNode: _focusNode_1,
                      onChanged: (value) => _onPinChanged(value, _focusNode_2),
                      obscureText: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                          color: _isFocusNode_1
                              ? const Color(0xff23413A)
                              : Colors.black,
                          fontFamily: 'Poppins Regular',
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: _isFocusNode_1
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          labelStyle: TextStyle(
                              color: const Color(0xff1C1C1C),
                              fontFamily: 'Poppins Regular',
                              fontSize: 15.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: _isFocusNode_1
                                      ? const Color(0xff23413A)
                                      : Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: input_2,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _onPinChanged(value, _focusNode_3),
                      focusNode: _focusNode_2,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                          color: _isFocusNode_2
                              ? const Color(0xff23413A)
                              : Colors.black,
                          fontFamily: 'Poppins Regular',
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: _isFocusNode_2
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          labelStyle: TextStyle(
                              color: const Color(0xff1C1C1C),
                              fontFamily: 'Poppins Regular',
                              fontSize: 15.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: _isFocusNode_2
                                      ? const Color(0xff23413A)
                                      : Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: input_3,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      focusNode: _focusNode_3,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _onPinChanged(value, _focusNode_4),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                          color: _isFocusNode_3
                              ? const Color(0xff23413A)
                              : Colors.black,
                          fontFamily: 'Poppins Regular',
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: _isFocusNode_3
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          labelStyle: TextStyle(
                              color: const Color(0xff1C1C1C),
                              fontFamily: 'Poppins Regular',
                              fontSize: 15.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: _isFocusNode_3
                                      ? const Color(0xff23413A)
                                      : Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: input_4,
                      obscureText: false,
                      focusNode: _focusNode_4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _onPinChanged(value, null),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                          color: _isFocusNode_4
                              ? const Color(0xff23413A)
                              : Colors.black,
                          fontFamily: 'Poppins Regular',
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: _isFocusNode_4
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          labelStyle: TextStyle(
                              color: const Color(0xff1C1C1C),
                              fontFamily: 'Poppins Regular',
                              fontSize: 15.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: _isFocusNode_4
                                      ? const Color(0xff23413A)
                                      : Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w, top: 30.h),
              child: GestureDetector(
                onTap: () {
                  String otp =
                      '${input_1.text}${input_2.text}${input_3.text}${input_4.text}';
                  verifyUser(
                      widget.email, otp, context, [triggerError, resendotp]);
                },
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
                      'Verify Account',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShakingRow extends StatefulWidget {
  final bool condition;
  final List<Widget> children;

  const ShakingRow(
      {super.key, required this.condition, required this.children});

  @override
  // ignore: library_private_types_in_public_api
  _ShakingRowState createState() => _ShakingRowState();
}

class _ShakingRowState extends State<ShakingRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 20)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant ShakingRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.condition) {
      _controller.repeat(reverse: true);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 1), () {
          _controller.stop();
          _controller.reset();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Row(children: widget.children),
        );
      },
    );
  }
}
