import 'package:e_commerce_test/features/home/data/datasources/home_remote_data_source.dart';
import 'package:e_commerce_test/features/home/domain/repositories/home_repository.dart';

import '../../domain/entities/product.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() {
    return _remoteDataSource.getProducts();
  }
}