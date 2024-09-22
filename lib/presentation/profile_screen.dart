import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'package:social_forum/business_logic/bottom_navvigation_provider.dart';
import 'package:social_forum/routing/navigation_controller.dart';

import '../business_logic/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          Center(
            child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Image.asset('assets/images/profilebig.png')),
          ),
          Center(
            child: Text(
              'Hey ${profileProvider.profile!.username}',
              style: TextStyle(
                  fontFamily: 'Otoma',
                  fontSize: 30.sp,
                  color: const Color(0xff23413A)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              'Minimum withdrawal- \$50',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 8.sp,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RouteManager.editProfile, arguments: {
                'fullName': context.read<ProfileProvider>().profile!.name,
                'username': context.read<ProfileProvider>().profile!.username,
                'email': context.read<ProfileProvider>().profile!.email,
                'password': context.read<ProfileProvider>().profile!.username,
              });
            },
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 80.w, right: 5.w),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.asset('assets/icons/edit.png'))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Center(
              child:
                  profileBox(title: 'FAQ', padding: 100, iconName: 'faq.png')),
          SizedBox(
            height: 20.h,
          ),
          Center(
              child: profileBox(
                  title: 'Contact Us', padding: 80, iconName: 'contact.png')),
          SizedBox(
            height: 20.h,
          ),
          Center(
              child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              context.read<AuthProvider>().destroyServerSession();
              context.read<ProfileProvider>().clearProfileStoredData();
              context.read<BottomNavProvider>().resetIndex();
            },
            child: profileBox(
                title: 'Logout', padding: 100, iconName: 'logout.png'),
          )),
        ],
      ),
    );
  }
}

Widget profileBox({String? title, double? padding, String? iconName}) {
  return Container(
    height: 50.h,
    width: 280.w,
    decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff23413A)),
        borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: padding!.w, right: 5.w),
          child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: Image.asset('assets/icons/$iconName')),
        ),
        Text(
          title!,
          style: TextStyle(
              fontFamily: 'Otoma',
              fontSize: 20.sp,
              color: const Color(0xff242424).withOpacity(0.8)),
        )
      ],
    ),
  );
}
