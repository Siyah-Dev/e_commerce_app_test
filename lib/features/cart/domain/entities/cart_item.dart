class CartItem {
  const CartItem({
    required this.productId,
    required this.title,
     this.price,
     this.image,
    this.quantity = 1,
  });

  final int productId;
  final String title;
  final double? price;
  final String? image;
  final int quantity;

  double get total => price??0.0 * quantity;

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }
}