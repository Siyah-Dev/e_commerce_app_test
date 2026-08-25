import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken =
        await _tokenStorage.getAccessToken();

    if (accessToken != null &&
        accessToken.isNotEmpty) {
      options.headers['Authorization'] =
          'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.response?.statusCode == 401) {
      // TODO: Handle token refresh or logout logic here
    }

    handler.next(err);
  }
}