import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    return response.data;
  }
}