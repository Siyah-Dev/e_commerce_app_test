import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';
import 'cart_state.dart';

final cartControllerProvider =
    NotifierProvider<CartController, CartState>(
  CartController.new,
);

class CartController extends Notifier<CartState> {
  @override
  CartState build() {
    return const CartState();
  }

  void addToCart({
    required int productId,
    required String title,
    // required double price,
    // required String image,
  }) {
    final items = [...state.items];

    final index = items.indexWhere(
      (item) => item.productId == productId,
    );

    if (index != -1) {
      final item = items[index];

      items[index] = item.copyWith(
        quantity: item.quantity + 1,
      );
    } else {
      items.add(
        CartItem(
          productId: productId,
          title: title,
          
        ),
      );
    }

    state = state.copyWith(items: items);
  }

  void removeFromCart(int productId) {
    final items = state.items
        .where((item) => item.productId != productId)
        .toList();

    state = state.copyWith(items: items);
  }

  void decreaseQuantity(int productId) {
    final items = [...state.items];

    final index = items.indexWhere(
      (item) => item.productId == productId,
    );

    if (index == -1) return;

    final item = items[index];

    if (item.quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = item.copyWith(
        quantity: item.quantity - 1,
      );
    }

    state = state.copyWith(items: items);
  }

  bool contains(int productId) {
    return state.items.any(
      (item) => item.productId == productId,
    );
  }

  int quantityOf(int productId) {
    return state.items
        .where((item) => item.productId == productId)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  void clearCart() {
    state = const CartState();
  }
}