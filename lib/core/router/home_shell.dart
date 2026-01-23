import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/core/router/app_routes.dart';

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

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.black,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,

        onTap: (index) {
          if (index == 0) context.go(AppRoutes.feed);
          if (index == 1) context.go(AppRoutes.search);
          if (index == 2) return;
          if (index == 3) context.go(AppRoutes.messages);
          if (index == 4) context.go(AppRoutes.profile);
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
