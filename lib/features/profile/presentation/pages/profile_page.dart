import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/core/widgets/bottom_sheet.dart';
import 'package:pinterest_clone/features/search/presentation/widgets/square_icon_button.dart';

import '../../../../core/router/app_routes.dart';
import '../provider/user_provider.dart';

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

class _ProfileHeader extends ConsumerWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    if(user==null){
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ElevatedButton(
            onPressed: (){
              context.push(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Login')
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: (){
          context.push(AppRoutes.account);
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
              ? NetworkImage(user.avatar!)
              : null,
          child: user.avatar == null || user.avatar!.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
      ),
    );
  }
}


class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return TabBar(
      indicatorColor: textColor,
      dividerColor: Colors.transparent,
      dividerHeight: 0,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        color: textColor?.withValues(alpha: 0.6)
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
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.push_pin, size: 100, color: textColor?.withValues(alpha: 0.5)),
            const SizedBox(height: 24),
            const Text(
              "Save what inspires you",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Saving Pins is Pinterest’s superpower. Browse Pins, save what you love, find them here to get inspired all over again.",
              style: TextStyle(color: textColor?.withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: textColor!.withValues(alpha: 0.5)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: textColor.withValues(alpha: 0.7)),
                    SizedBox(width: 8),
                    Text("Search your Pins", style: TextStyle(color: textColor.withValues(alpha: 0.7))),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            SquareIconButton(
                icon: Icons.add,
                height: 48,
                width: 48,
                onTap: () {
                  CustomBottomSheet.showCreateBottomSheet(context);
                }
            ),
          ],
        ),
        const SizedBox(height: 24),

        Container(
          height: 140,
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 8),
        const Text("quotes", style: TextStyle(fontSize: 18)),
        Text("0 Pins • 5y", style: TextStyle(color: textColor.withValues(alpha: 0.6))),
      ],
    );
  }
}

class _CollagesTab extends StatelessWidget {
  const _CollagesTab();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.content_cut, size: 120, color: textColor?.withValues(alpha: 0.5)),
            const SizedBox(height: 24),
            const Text(
              "Make your first collage",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Snip-and-paste the best parts of your favorite Pins to create something completely new.",
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor?.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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


