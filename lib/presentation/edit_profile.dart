import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  final String fullName;
  final String username;
  final String email;
  final String pasword;
  const EditProfileScreen(
      {super.key,
      required this.fullName,
      required this.username,
      required this.email,
      required this.pasword});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool togglePassword = true;
  bool showObscure = true;

  @override
  void initState() {
    fullName.text = widget.fullName;
    email.text = widget.email;
    username.text = widget.username;
    password.text = widget.pasword;
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    fullName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE9F5F2),
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: 900.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    child: Container(
                  height: 250.h,
                  width: 380.w,
                  color: const Color(0xff23413A),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, bottom: 130.h),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 120.h, left: 40.w),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
                Positioned(
                    top: 150.h,
                    left: 100.w,
                    child: Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 5.0,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.blueGrey),
                    )),
                Positioned(
                    top: 293.h,
                    left: 125.w,
                    child: Text(
                      'Change Avatar',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.sp,
                          color: const Color(0xff23413A),
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                    top: 300.h,
                    left: 15.w,
                    child: SizedBox(
                      height: 390.h,
                      width: 340.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 95.w, top: 20.h),
                            child: Text(
                              'Username',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 10.sp,
                                  color: const Color(0xff202224),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                              clipBehavior: Clip.none,
                              width: 330.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF1F4F9),
                                  border: Border.all(
                                      color: const Color(0xff23413A)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: username,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: const Color(0xffA6A6A6),
                                        fontFamily: 'Nunito',
                                        fontSize: 12.sp),
                                    contentPadding: EdgeInsets.only(left: 6.w)),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 95.w, top: 20.h),
                            child: Text(
                              'Full Name',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 10.sp,
                                  color: const Color(0xff202224),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                              width: 330.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF1F4F9),
                                  border: Border.all(
                                      color: const Color(0xff23413A)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: fullName,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Full Name',
                                    hintStyle: TextStyle(
                                        color: const Color(0xffA6A6A6),
                                        fontFamily: 'Nunito',
                                        fontSize: 12.sp),
                                    contentPadding: EdgeInsets.only(left: 6.w)),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 95.w, top: 20.h),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 10.sp,
                                  color: const Color(0xff202224),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                              width: 330.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: const Color(0xff23413A)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: email,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: const Color(0xffA6A6A6),
                                        fontFamily: 'Nunito',
                                        fontSize: 12.sp),
                                    contentPadding: EdgeInsets.only(left: 6.w)),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 95.w, top: 20.h),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 10.sp,
                                  color: const Color(0xff202224),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                              width: 330.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF1F4F9),
                                  border: Border.all(
                                      color: const Color(0xff23413A)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                    width: 300.w,
                                    child: TextFormField(
                                      obscureText: showObscure,
                                      controller: password,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                              color: const Color(0xffA6A6A6),
                                              fontFamily: 'Nunito',
                                              fontSize: 12.sp),
                                          contentPadding:
                                              EdgeInsets.only(left: 6.w)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          togglePassword = !togglePassword;
                                          showObscure = !showObscure;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 15.h,
                                        width: 15.w,
                                        child: Image.asset(
                                            togglePassword == false
                                                ? 'assets/icons/view.png'
                                                : 'assets/icons/hide.png'),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: Container(
                              width: 250.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff23413A),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Update Profile',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 12.sp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
