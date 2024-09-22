import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'dart:convert';

import '../routing/navigation_controller.dart';

Future<void> loginUser(AuthProvider loginProvider, String username,
    String password, BuildContext context, Function command) async {
  try {
    const storage = FlutterSecureStorage();
    final response = await http.post(
      Uri.parse('https://famouzcoder.com/flutter_auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (!context.mounted) return; // Ensure the widget is still mounted

    // Print the raw response body

    final responseData = json.decode(response.body);
    debugPrint('Server error: ${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('raw datalek: ${response.body}');
      if (responseData['status'] == 'success') {
        await storage.write(
            key: 'session_token', value: responseData['sessionToken']);
        if (context.mounted) {
          context.read<AuthProvider>().sessionToken =
              (await storage.read(key: 'session_token'))!;
        }
        if (context.mounted) {
          Navigator.of(context).pushNamed(RouteManager.dashboard);
        }
        command();
        debugPrint('Registration Successful: ${responseData.toString()}');
      } else if (responseData['status'] == 'username-error') {
        debugPrint('Registration failed: ${responseData.toString()}');
      } else if (responseData['status'] == 'not-verified') {
        debugPrint(responseData.toString());
        if (context.mounted) {
          Navigator.of(context).pushNamed(RouteManager.verfifyAccount,
              arguments: {'email': responseData['email']});
        }
      }
    } else if (response.statusCode == 400) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.only(bottom: 450.h),

        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Invaild Username/Password',

          titleFontSize: 10.sp,
          message: 'The username or password you entered is incorrect.',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          snackBar,
        );
      debugPrint('Server error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}
