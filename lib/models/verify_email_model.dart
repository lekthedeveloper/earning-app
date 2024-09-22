import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'dart:convert';
import '../routing/navigation_controller.dart';

Future<void> verifyUser(String email, String otpCode, BuildContext context,
    List<Function>? callFunction) async {
  try {
    const storage = FlutterSecureStorage();
    final response = await http.post(
      Uri.parse('https://famouzcoder.com/flutter_auth/verify'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'otp_code': otpCode,
      }),
    );

    if (!context.mounted) return; // Ensure the widget is still mounted

    debugPrint('Response status: ${response.statusCode}');
    debugPrint(
        'Response body: ${response.body}'); // Print the raw response body

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
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
        debugPrint('Verification-status: ${responseData.toString()}');
      }
    } else if (response.statusCode == 400) {
      for (var function in callFunction!) {
        function();
      }
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}

Future<void> resendOtp(
  String email,
) async {
  try {
    final response = await http.post(
      Uri.parse('https://famouzcoder.com/flutter_auth/regenerate-otp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseData['status'] == 'success') {
        debugPrint('otp-status: ${responseData.toString()}');
      }
    } else if (response.statusCode == 400) {}
  } catch (e) {
    debugPrint('Error: $e');
  }
}
