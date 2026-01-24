import 'package:flutter/material.dart';

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

class _ProfileHeaderTile extends StatelessWidget {
  const _ProfileHeaderTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 24,
        backgroundColor: Colors.red,
        child: Text("R", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      title: const Text(
        "ritesh",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        "View profile",
        style: TextStyle(color: Colors.white54),
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

class _LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text(
        "Log out",
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
      },
    );
  }
}

