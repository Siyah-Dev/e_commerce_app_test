import 'package:e_commerce_test/core/router/route_names.dart';
import 'package:e_commerce_test/core/widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_test/features/auth/presentation/controllers/auth_controller.dart';
import 'package:e_commerce_test/features/auth/presentation/controllers/auth_state.dart';
import 'package:e_commerce_test/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_test/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce_test/features/favourite/presentation/pages/favorite_page.dart';
import 'package:e_commerce_test/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_test/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {
      final location = state.matchedLocation;

      final isLoginPage = location == '/login';

      if (authState.status == AuthStatus.initial) {
        return null;
      }

      if (authState.status == AuthStatus.loading) {
        return null;
      }

      if (authState.status == AuthStatus.authenticated) {
        if (isLoginPage) {
          return '/home';
        }

        return null;
      }

      if (authState.status == AuthStatus.unauthenticated ||
          authState.status == AuthStatus.failure) {
        if (isLoginPage) {
          return null;
        }

        return '/login';
      }

      return null;
    },

    routes: [
      GoRoute(
        name: RouteNames.login,
        path: '/login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.home,
                path: '/home',
                builder: (context, state) {
                  return const HomePage();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.favorites,
                path: '/favorites',
                builder: (context, state) {
                  return const FavoritesPage();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.cart,
                path: '/cart',
                builder: (context, state) {
                  return const CartPage();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.profile,
                path: '/profile',
                builder: (context, state) {
                  return const ProfilePage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class MainShell extends StatelessWidget {
  const MainShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onItemSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}