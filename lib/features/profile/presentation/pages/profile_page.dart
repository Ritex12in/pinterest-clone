import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Row(
                children: [
                  _ProfileHeader(),
                  Expanded(child: _ProfileTabs()),
                  SizedBox(width: 16),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _PinsTab(),
                    _BoardsTab(),
                    _CollagesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: (){
          context.push(AppRoutes.account);
        },
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: Text("R", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}


class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.white,
      dividerColor: Colors.transparent,
      dividerHeight: 0,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      tabs: [
        Tab(text: "Pins"),
        Tab(text: "Boards"),
        Tab(text: "Collages"),
      ],
    );
  }
}

class _PinsTab extends StatelessWidget {
  const _PinsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.push_pin, size: 100, color: Colors.white24),
            const SizedBox(height: 24),
            const Text(
              "Save what inspires you",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Saving Pins is Pinterest’s superpower. Browse Pins, save what you love, find them here to get inspired all over again.",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {},
              child: const Text("Explore Pins"),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardsTab extends StatelessWidget {
  const _BoardsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: 8),
                    Text("Search your Pins", style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.add, size: 28),
          ],
        ),
        const SizedBox(height: 24),

        Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 8),
        const Text("quotes", style: TextStyle(fontSize: 18)),
        const Text("0 Pins • 5y", style: TextStyle(color: Colors.white54)),
      ],
    );
  }
}

class _CollagesTab extends StatelessWidget {
  const _CollagesTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.content_cut, size: 120, color: Colors.white24),
            const SizedBox(height: 24),
            const Text(
              "Make your first collage",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Snip-and-paste the best parts of your favorite Pins to create something completely new.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {},
              child: const Text("Create collage"),
            ),
          ],
        ),
      ),
    );
  }
}


