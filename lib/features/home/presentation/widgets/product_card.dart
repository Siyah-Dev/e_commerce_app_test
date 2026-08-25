import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onFavorite,
  });

  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(
              onFavorite: onFavorite,
            ),
            const SizedBox(height: 8),
            _ProductCode(
              code: product.code,
            ),
            const SizedBox(height: 5),
            _ProductName(
              name: product.name,
            ),
            const Spacer(),
            _ProductBottomRow(
              product: product,
              onAdd: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.onFavorite,
  });

  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.fastfood_outlined,
                size: 64,
                color: Color(0xFFB8C5BD),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onFavorite,
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(7),
                  child: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Color(0xFFE96BA8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCode extends StatelessWidget {
  const _ProductCode({
    required this.code,
  });

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: Color(0xFF167A5C),
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  const _ProductName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        height: 1.2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ProductBottomRow extends StatelessWidget {
  const _ProductBottomRow({
    required this.product,
    required this.onAdd,
  });

  final Product product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Code ${product.code}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _AddButton(
          onPressed: onAdd,
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF006B52),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}