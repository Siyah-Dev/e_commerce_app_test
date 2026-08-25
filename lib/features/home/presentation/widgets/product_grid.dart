import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.onAdd,
    required this.onFavorite,
  });

  final List<Product> products;
  final ValueChanged<Product> onAdd;
  final ValueChanged<Product> onFavorite;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        24,
      ),
      sliver: SliverGrid.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            onAdd: () => onAdd(product),
            onFavorite: () => onFavorite(product),
          );
        },
      ),
    );
  }
}