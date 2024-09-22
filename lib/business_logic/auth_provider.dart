import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/profile_provider.dart';

import '../models/profile_model.dart';

class AuthProvider with ChangeNotifier {
  // Stream to simulate auth state changes

  final String _checkTokenUrl =
      'https://famouzcoder.com/flutter_auth/checkSession';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String _sessionToken = '';

  String get sessionToken => _sessionToken;

  set sessionToken(String token) {
    _sessionToken = token;
    notifyListeners();
  }

  void login(String token) {
    _sessionToken = token;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'session_token');
      _sessionToken = '';
      notifyListeners();
      debugPrint('Token deleted successfully');
    } catch (error) {
      debugPrint('Error deleting token: $error');
    }
  }

  Future<void> destroyServerSession() async {
    const String checkTokenUrl = 'https://famouzcoder.com/flutter_auth/logout';
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: 'session_token');
    if (token!.isEmpty) {
      return; // No token to check
    }
    try {
      final response = await http.post(Uri.parse(checkTokenUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          await logout(); // logout user out locally
          debugPrint('Logout successfully');
        }
      } else {
        debugPrint('Server error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error checking token validity: $error');
    }
  }

  Future<void> loadToken() async {
    try {
      final token = await _storage.read(key: 'session_token');
      _sessionToken = token ?? ''; // Set to empty string if token is null
      await _checkTokenValidity();
      notifyListeners();
      // debugPrint('Token loaded successfully: $_sessionToken');
    } catch (error) {
      debugPrint('Error loading token: $error');
    }
  }

  Future<void> _checkTokenValidity() async {
    final token = await _storage.read(key: 'session_token');
    if (_sessionToken.isEmpty) {
      return; // No token to check
    }

    try {
      final response = await http.get(Uri.parse(_checkTokenUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      final responseData = json.decode(response.body);
      debugPrint('return: $responseData');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == false) {
          await logout(); // Token is not valid; log out the user
          debugPrint('token not valid');
        }
      } else {
        debugPrint('Server error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error checking token validity: $error');
    }
  }

  Future<void> getUserDetails(BuildContext context) async {
    final token = await _storage.read(key: 'session_token');
    if (token == null || token.isEmpty) {
      debugPrint('No token to check');
      return; // No token to check
    }

    try {
      final response = await http.post(
          Uri.parse('https://famouzcoder.com/flutter_auth/user-data'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        debugPrint('vvv: $responseData');
        if (responseData['status'] == 'success') {
          if (context.mounted) {
            final profile = ProfileModel.fromJson(responseData['data']);
            context.read<ProfileProvider>().profileDetails(profile);
          }
        }
      } else {
        debugPrint('Server error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error checking token validity: $error');
    }
  }
}
