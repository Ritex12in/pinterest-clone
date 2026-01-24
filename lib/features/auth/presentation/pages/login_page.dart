import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ClerkAuthBuilder(
            signedInBuilder: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });

              return const SizedBox.shrink();
            },
            signedOutBuilder: (context, state) {
              return const ClerkAuthentication();
            },
          ),
        ),
      ),
    );
  }
}
