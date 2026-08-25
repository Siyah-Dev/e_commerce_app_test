import '../../domain/entities/cart_item.dart';

class CartState {
  const CartState({
    this.items = const [],
  });

  final List<CartItem> items;

  double get subtotal {
    return items.fold(
      0,
      (sum, item) => sum + item.total,
    );
  }

  double get deliveryFee {
    return items.isEmpty ? 0 : 2;
  }

  double get total {
    return subtotal + deliveryFee;
  }

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}