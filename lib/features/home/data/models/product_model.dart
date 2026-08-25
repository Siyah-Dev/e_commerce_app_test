import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.code,
    required super.barcode,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['productId'] as int? ?? 0,
      name: json['productName'] as String? ?? '',
      code: json['code'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
    );
  }
}