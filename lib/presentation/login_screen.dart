import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:social_forum/business_logic/auth_provider.dart';
import 'package:social_forum/business_logic/registration_provider.dart';
import 'package:social_forum/models/login_model.dart';
import 'package:social_forum/models/signup_model.dart';
import 'package:social_forum/routing/navigation_controller.dart';

import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final regFirstName = TextEditingController();
  String getuser = '';
  final regEmail = TextEditingController();
  final preferredUsername = TextEditingController();
  final regPassword = TextEditingController();
  final renterPass = TextEditingController();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  void clearField() {
    setState(() {
      username.clear();
      password.clear();
    });
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    regFirstName.dispose();

    regEmail.dispose();
    preferredUsername.dispose();
    regPassword.dispose();
    renterPass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
            key: _formKey,
            child: Center(
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                direction: FlipDirection.HORIZONTAL,
                front: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200.h, left: 50.w),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontFamily: 'Otoma',
                            fontSize: 39.sp,
                            color: const Color(0xff23413A)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w),
                      child: Text(
                        'Welcome back',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 10.sp,
                            color: const Color(0xff656865)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.w, top: 50.h),
                        child: CustomTextFormField(
                          controller: username,
                          title: 'Username',
                          hint: 'user@1362',
                          iconName: 'username.png',
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 10.h),
                      child: CustomTextFormField(
                        controller: password,
                        title: 'Password',
                        hint: '********',
                        iconName: 'password.png',
                        hintFontSize: 15,
                        showObscure: true,
                        showObsucureFunction: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 30.h),
                      child: GestureDetector(
                        onTap: () {
                          loginUser(context.read<AuthProvider>(), username.text,
                              password.text, context, clearField);
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
                              'Sign In',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 20.h),
                      child: Row(
                        children: [
                          Text(
                            'New member?',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                color: const Color(0xff959595),
                                fontSize: 10.sp),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                username.clear();
                                password.clear();
                              });
                              cardKey.currentState?.toggleCard();
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 10.sp,
                                  color: const Color(0xff23413A)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                back: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 100.h, left: 0.w, right: 120.w),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: 'Otoma',
                            fontSize: 39.sp,
                            color: const Color(0xff23413A)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 100.w),
                      child: Text(
                        'Create a new account',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 10.sp,
                            color: const Color(0xff656865)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 50.h),
                        child: CustomTextFormField(
                          controller: regFirstName,
                          title: 'Full Name',
                          hint: 'Enter your fullname here',
                          iconName: 'username.png',
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 10.h),
                        child: CustomTextFormField(
                          controller: regEmail,
                          title: 'Email',
                          hint: 'Your preferred email',
                          iconName: 'email.png',
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 10.h),
                        child: CustomTextFormField(
                          controller: preferredUsername,
                          title: 'Username',
                          hint: 'Your preferred username',
                          iconName: 'username.png',
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 10.h),
                        child: CustomTextFormField(
                          controller: regPassword,
                          title: 'Password',
                          hint: '********',
                          iconName: 'password.png',
                          hintFontSize: 15,
                          showObsucureFunction: true,
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 10.h),
                        child: CustomTextFormField(
                          controller: renterPass,
                          title: 'Confirm',
                          hint: 'Confirm password ',
                          iconName: 'password.png',
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w, top: 10.h),
                      child: Consumer<RegistrationProvider>(
                        builder: (context, value, child) {
                          if (value.status == '') {
                            return AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              width: 260.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF7D2D2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                'This username has already been taken.',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 9.sp,
                                    color: const Color(0xffC44B4B)),
                              )),
                            );
                          } else {
                            return SizedBox(
                              width: 260.w,
                              height: 25.h,
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w, top: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          registerUser(
                              context.read<RegistrationProvider>(),
                              regFirstName.text,
                              regEmail.text,
                              preferredUsername.text,
                              regPassword.text,
                              context);
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
                              'Sign Up',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w, top: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteManager.dashboard);
                        },
                        child: Container(
                          width: 260.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: const Color(0xff959595),
                                    fontSize: 10.sp),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: () => cardKey.currentState?.toggleCard(),
                                child: Text(
                                  'Sign in.',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 10.sp,
                                      color: const Color(0xff23413A)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

// ignore: must_be_immutable
