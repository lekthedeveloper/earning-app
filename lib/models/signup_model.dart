import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';
import 'dart:convert';

import 'package:social_forum/business_logic/registration_provider.dart';
import '../routing/navigation_controller.dart';

Future<void> registerUser(
    RegistrationProvider registrationProvider,
    String fullname,
    String email,
    String username,
    String password,
    BuildContext context) async {
  try {
    const storage = FlutterSecureStorage();
    final response = await http.post(
      Uri.parse('https://famouzcoder.com/flutter_auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': fullname,
        'email': email,
        'username': username,
        'password': password,
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
        debugPrint('Registration Successful: ${responseData.toString()}');
      } else if (responseData['status'] == 'username-error') {
        registrationProvider.updateStatus('');
        debugPrint('Registration failed: ${responseData.toString()}');
      }
    } else {
      debugPrint('Server error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}
