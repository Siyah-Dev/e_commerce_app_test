import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/product_model.dart';

class HomeRemoteDataSource {
  HomeRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get(
      ApiConstants.productList,
    );

    final responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      throw const FormatException(
        'Invalid product response format.',
      );
    }

    final data = responseData['data'];

    if (data is! List) {
      throw const FormatException(
        'Product data is not a list.',
      );
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }
}