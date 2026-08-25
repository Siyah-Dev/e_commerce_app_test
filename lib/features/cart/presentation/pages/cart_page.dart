import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';
import '../widgets/checkout_button.dart';

class CartPage extends ConsumerWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.star_rounded,
              color: Color(0xFFF15A24),
              size: 30,
            ),
          ),
        ],
      ),
      body: cart.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final item = cart.items[index];

                      return CartItemCard(
                        item: item,
                        onDelete: () {
                          ref
                              .read(
                                cartControllerProvider.notifier,
                              )
                              .removeFromCart(item.productId);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    0,
                    24,
                    20,
                  ),
                  child: Column(
                    children: [
                      CartSummary(
                        subtotal: cart.subtotal,
                        deliveryFee: cart.deliveryFee,
                        total: cart.total,
                      ),
                      const SizedBox(height: 20),
                      CheckoutButton(
                        onPressed: () {
                          // TODO: checkout
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Your cart is empty',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}