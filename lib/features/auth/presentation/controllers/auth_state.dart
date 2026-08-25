import 'package:e_commerce_test/features/auth/domain/entities/auth_response_entity.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
  authenticated,
  unauthenticated,
}

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.user,
  });

  final AuthStatus status;
  final String? errorMessage;
  final LoginResponseEntity? user;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated;

  bool get isUnauthenticated =>
      status == AuthStatus.unauthenticated;

  bool get isLoading =>
      status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    LoginResponseEntity? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}