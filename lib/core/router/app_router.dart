import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/feed/data/models/pexels_photo.dart';
import '../../features/feed/presentation/pages/feed_page.dart';
import '../../features/pin_detail/presentation/pages/pin_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../main.dart';
import 'home_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authStatusProvider);

  return GoRouter(
    initialLocation: '/feed',
    redirect: (context, state) {
      final isLogin = state.matchedLocation == '/login';

      if (authStatus == AuthStatus.signedOut) {
        return isLogin ? null : '/login';
      }

      if (authStatus == AuthStatus.signedIn) {
        return isLogin ? '/feed' : null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return HomeShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/feed',
            builder: (_, __) => const FeedPage(),
          ),
          GoRoute(
            path: '/search',
            builder: (_, __) => const SearchPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfilePage(),
          ),
        ],
      ),

      GoRoute(
        path: '/pin/:id',
        builder: (context, state) {
          final photo = state.extra as PexelsPhoto;
          return PinDetailPage(photo: photo);
        },
      ),
    ],
  );
});
