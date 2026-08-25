import 'package:e_commerce_test/features/auth/data/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import 'auth_state.dart';

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }


  Future<void> checkAuthStatus() async {
    try {
      final hasToken =
          await ref.read(tokenStorageProvider).hasAccessToken();

      if (hasToken) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
        );
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
        );
      }
    } catch (_) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
      );
    }
  }

  Future<bool> login({
    required String userName,
    required String password,
  }) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      final loginUseCase =
          ref.read(loginUseCaseProvider);

      final response = await loginUseCase(
        userName: userName,
        password: password,
      );

      if (response.accessToken.isEmpty) {
        state = state.copyWith(
          status: AuthStatus.failure,
          errorMessage:
              'Access token was not received.',
        );

        return false;
      }

      await ref.read(tokenStorageProvider).saveTokens(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
          );

      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: response,
        errorMessage: null,
      );

      return true;
    } catch (error) {
      state = state.copyWith(
        status: AuthStatus.failure,
        errorMessage: _getErrorMessage(error),
      );

      return false;
    }
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearTokens();

    state = const AuthState(
      status: AuthStatus.unauthenticated,
    );
  }

  String _getErrorMessage(Object error) {
    return 'Login failed. Please check your credentials.';
  }
}