import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/core/router/app_routes.dart';
import 'package:pinterest_clone/features/search/presentation/pages/search_home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/feed/data/models/pexels_photo.dart';
import '../../features/feed/presentation/pages/feed_page.dart';
import '../../features/message/presentation/pages/messages_page.dart';
import '../../features/pin_detail/presentation/pages/pin_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/search/presentation/pages/search_input_page.dart';
import '../../features/search/presentation/pages/search_results_page.dart';
import '../../main.dart';
import 'home_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authStatusProvider);

  return GoRouter(
    initialLocation: AppRoutes.feed,
    // redirect: (context, state) {
    //   final isLogin = state.matchedLocation == AppRoutes.login;
    //
    //   if (authStatus == AuthStatus.signedOut) {
    //     return isLogin ? null : AppRoutes.login;
    //   }
    //
    //   if (authStatus == AuthStatus.signedIn) {
    //     return isLogin ? AppRoutes.feed : null;
    //   }
    //
    //   return null;
    // },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return HomeShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.feed,
            builder: (_, __) => const FeedPage(),
          ),
          GoRoute(
            path: AppRoutes.search,
            builder: (_, __) => const SearchHomePage(),
          ),
          GoRoute(
            path: AppRoutes.messages,
            builder: (context, state) => const MessagesPage(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (_, __) => const ProfilePage(),
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.pin,
        builder: (context, state) {
          final photo = state.extra as PexelsPhoto;
          return PinDetailPage(photo: photo);
        },
      ),

      GoRoute(
        path: AppRoutes.searchFeed,
        builder: (context, state) {
          final query = state.pathParameters['query']!;
          return SearchResultsPage(query: query);
        },
      ),

      GoRoute(
        path: '/search-input',
        builder: (context, state) {
          final initial = state.uri.queryParameters['q'];
          return SearchInputPage(initialQuery: initial);
        },
      ),

    ],
  );
});
