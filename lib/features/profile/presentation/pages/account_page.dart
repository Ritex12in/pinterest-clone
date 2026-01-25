import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/core/router/app_routes.dart';

import '../provider/user_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your account"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),

          _ProfileHeaderTile(),

          const SizedBox(height: 24),
          const _SectionTitle("Settings"),

          _SettingsTile("Account management"),
          _SettingsTile("Profile visibility"),
          _SettingsTile("Refine your recommendations"),
          _SettingsTile("Claimed external accounts"),
          _SettingsTile("Social permissions"),
          _SettingsTile("Notifications"),
          _SettingsTile("Privacy and data"),
          _SettingsTile("Reports and violations center"),

          const SizedBox(height: 24),
          const _SectionTitle("Login"),

          _SettingsTile("Add account"),
          _SettingsTile("Security"),
          _LogoutTile(),

          const SizedBox(height: 24),
          const _SectionTitle("Support"),

          _SettingsTile("Help center"),
          _SettingsTile("About"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ProfileHeaderTile extends ConsumerWidget {
  const _ProfileHeaderTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey,
        backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
            ? NetworkImage(user.avatar!)
            : null,
        child: user.avatar == null || user.avatar!.isEmpty
            ? const Icon(Icons.person)
            : null,
      ),
      title: Text(
        user.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "View profile",
        style: TextStyle(color: textColor?.withValues(alpha: 0.6)),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;

  const _SettingsTile(this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _LogoutTile extends ConsumerWidget {
  const _LogoutTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text(
        "Log out",
        style: TextStyle(color: Colors.red),
      ),
      onTap: () async {
        final clerk = ClerkAuth.of(context);
        await clerk.signOut();
        context.push(AppRoutes.login);
      },
    );
  }
}


