import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 32),
        _SummaryRow(
          label: 'Subtotal',
          value: subtotal,
        ),
        const SizedBox(height: 18),
        _SummaryRow(
          label: 'Delivery Fee',
          value: deliveryFee,
        ),
        const Divider(height: 36),
        _SummaryRow(
          label: 'Total',
          value: total,
          isTotal: true,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final double value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 21 : 16,
            fontWeight: isTotal
                ? FontWeight.w800
                : FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}