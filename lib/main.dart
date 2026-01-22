import 'package:flutter/material.dart';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'core/constants/clerk_keys.dart';
import 'core/router/app_router.dart';

enum AuthStatus { signedIn, signedOut }

final authStatusProvider =
StateProvider<AuthStatus>((ref) => AuthStatus.signedOut);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: Root()));
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClerkAuth(
      config: ClerkAuthConfig(
        publishableKey: CLERK_PUBLISHABLE_KEY,
      ),
      child: ClerkErrorListener(
        child: ClerkAuthBuilder(
          signedInBuilder: (context, state) {
            Future.microtask(() {
              ref.read(authStatusProvider.notifier).state = AuthStatus.signedIn;
            });
            return const MyApp();
          },
          signedOutBuilder: (context, state) {
            Future.microtask(() {
              ref.read(authStatusProvider.notifier).state = AuthStatus.signedOut;
            });
            return const MyApp();
          },
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
