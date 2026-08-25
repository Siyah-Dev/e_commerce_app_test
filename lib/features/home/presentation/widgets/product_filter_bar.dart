import 'package:e_commerce_test/features/home/presentation/controllers/home_state.dart';
import 'package:flutter/material.dart';


class ProductFilterBar extends StatelessWidget {
  const ProductFilterBar({
    super.key,
    required this.selectedSort,
    required this.onSortChanged,
  });

  final ProductSort selectedSort;
  final ValueChanged<ProductSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterButton(
          icon: Icons.tune,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterButton(
            icon: Icons.swap_vert,
            label: 'Sort By',
            onTap: () => _showSortOptions(context),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: _FilterButton(
            label: 'Category',
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: _FilterButton(
            label: 'Offers',
          ),
        ),
      ],
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  'Sort Products',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              RadioListTile<ProductSort>(
                value: ProductSort.nameAscending,
                groupValue: selectedSort,
                title: const Text('Name: A to Z'),
                onChanged: (value) {
                  if (value == null) return;

                  onSortChanged(value);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<ProductSort>(
                value: ProductSort.nameDescending,
                groupValue: selectedSort,
                title: const Text('Name: Z to A'),
                onChanged: (value) {
                  if (value == null) return;

                  onSortChanged(value);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    this.icon,
    this.label,
    this.onTap,
  });

  final IconData? icon;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 18,
            color: Colors.black87,
          ),
          if (label != null) const SizedBox(width: 6),
        ],
        if (label != null)
          Flexible(
            child: Text(
              label!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          child: child,
        ),
      ),
    );
  }
}