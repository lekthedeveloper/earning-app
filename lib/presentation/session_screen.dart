import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_forum/presentation/dashboard.dart';
import 'package:social_forum/presentation/login_screen.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<String?>? _tokenFuture;

  @override
  void initState() {
    super.initState();
    _tokenFuture = _storage.read(key: 'session_token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _tokenFuture,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        // Check if the token has been loaded
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading token'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return const Dashboard();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
