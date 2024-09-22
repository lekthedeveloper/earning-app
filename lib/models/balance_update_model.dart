import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/ads_provider.dart';
import 'package:social_forum/business_logic/auth_provider.dart';

const FlutterSecureStorage _storage = FlutterSecureStorage();
Future<void> updatePointBalance(
    BuildContext context, double earnedPoint) async {
  final token = await _storage.read(key: 'session_token');
  if (token == null || token.isEmpty) {
    debugPrint('No token to check');
    return; // No token to check
  }

  try {
    final response = await http.post(
      Uri.parse('https://famouzcoder.com/flutter_auth/spin-earn'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'earnAmount': '$earnedPoint',
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      debugPrint('vvv: $responseData');
      debugPrint(
          ' before point: ${context.read<WalletProvider>().totalEarning}');
      if (responseData['status'] == 'success') {
        debugPrint('status :$responseData');
        if (context.mounted) {
          context.read<WalletProvider>().clearEarning();
          context.read<AuthProvider>().getUserDetails(context);
        }
        debugPrint(
            ' after point: ${context.read<WalletProvider>().totalEarning}');
      }
    } else if (response.statusCode == 400) {
      debugPrint('error: $responseData');
      debugPrint('point: $earnedPoint');
      debugPrint(response.body);
    }
  } catch (error) {
    debugPrint('Error checking token validity: $error');
  }
}
