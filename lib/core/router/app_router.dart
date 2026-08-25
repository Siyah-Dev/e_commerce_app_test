import 'package:e_commerce_test/features/auth/presentation/controllers/auth_controller.dart';
import 'package:e_commerce_test/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import 'route_names.dart';

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

      GoRoute(
        name: RouteNames.home,
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        },
      ),

      GoRoute(
        name: RouteNames.cart,
        path: '/cart',
        builder: (context, state) {
          return const CartPage();
        },
      ),
    ],
  );
});