import 'package:flutter/material.dart';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/api_keys.dart';
import 'core/router/app_router.dart';
import 'features/profile/domain/model/app_user.dart';
import 'features/profile/presentation/provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  runApp(const ProviderScope(child: Root()));
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClerkAuth(
      config: ClerkAuthConfig(publishableKey: CLERK_PUBLISHABLE_KEY),
      child: ClerkErrorListener(
        child: ClerkAuthBuilder(
          builder: (context, authState) {
            final user = authState.user;
            if (user != null) {
              Future.microtask((){
                ref.read(appUserProvider.notifier).state = AppUser(
                  id: user.id,
                  name: user.firstName ?? "User",
                  avatar: user.profileImageUrl,
                );
              });
            }
            FlutterNativeSplash.remove();
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
      builder: (context, child) {
        return ClerkErrorListener(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
