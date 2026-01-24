import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/core/router/app_routes.dart';
import 'package:pinterest_clone/core/widgets/nav_icon.dart';

class HomeShell extends StatelessWidget {
  final Widget child;

  const HomeShell({super.key, required this.child});

  int _indexFromLocation(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.startsWith(AppRoutes.search)) return 1;
    if (location.startsWith(AppRoutes.messages)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;

    return 0;
  }


  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(context);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: textColor,
        unselectedItemColor: textColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 0) context.go(AppRoutes.feed);
          if (index == 1) context.go(AppRoutes.search);
          if (index == 2) return;
          if (index == 3) context.go(AppRoutes.messages);
          if (index == 4) context.go(AppRoutes.profile);
        },

        items: const [
          BottomNavigationBarItem(
              icon: NavIcon(icon: 'assets/vectors/home_unselected.svg'),
              activeIcon: NavIcon(icon: 'assets/vectors/home_selected.svg'),
              label: 'Feed'
          ),
          BottomNavigationBarItem(
            icon: NavIcon(icon: 'assets/vectors/search_unselected.svg'),
            activeIcon: NavIcon(icon: 'assets/vectors/search_selected.svg'),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(icon: 'assets/vectors/plus_unselected.svg'),
            activeIcon: NavIcon(icon: 'assets/vectors/plus_selected.svg'),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(icon: 'assets/vectors/message_unselected.svg'),
            activeIcon: NavIcon(icon: 'assets/vectors/message_selected.svg'),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(icon: 'assets/vectors/user_unselected.svg'),
            activeIcon: NavIcon(icon: 'assets/vectors/user_selected.svg'),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
