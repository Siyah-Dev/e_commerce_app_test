import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dioProvider = Provider<Dio>((ref) {
  return DioClient().dio;
});

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://77.92.176.150:8069/api',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'accept': '/',
          'clientDb': 'app_db',
          'Content-Type': 'application/json',
        },
      ),
    );

  }
}