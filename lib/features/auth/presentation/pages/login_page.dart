import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: ClerkAuthentication()),
      ),
    );
  }
}
