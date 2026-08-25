import '../entities/product.dart';

abstract interface class HomeRepository {
  Future<List<Product>> getProducts();
}