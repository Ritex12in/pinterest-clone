import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await ClerkAuth.of(context).signOut();
        },
        child: const Text("Logout"),
      ),
    );
  }
}
