import 'package:e_commerce_test/features/cart/presentation/controllers/cart_controller.dart';
import 'package:e_commerce_test/features/home/presentation/controllers/home_state.dart';
import 'package:e_commerce_test/features/home/presentation/providers/home_providers.dart';
import 'package:e_commerce_test/features/home/presentation/widgets/product_action_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/product_empty_state.dart';
import '../widgets/product_error_state.dart';
import '../widgets/product_filter_bar.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/product_section_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF006B52),
          onRefresh: () {
            return ref.read(homeControllerProvider.notifier).refreshProducts();
          },
          child: _HomeBody(
            state: state,
            onSearch: ref.read(homeControllerProvider.notifier).searchProducts,
            onSortChanged: ref.read(homeControllerProvider.notifier).sortProducts,
            onRetry: ref.read(homeControllerProvider.notifier).loadProducts,
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({
    required this.state,
    required this.onSearch,
    required this.onSortChanged,
    required this.onRetry,
  });

  final HomeState state;
  final ValueChanged<String> onSearch;
  final ValueChanged<ProductSort> onSortChanged;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF006B52),
        ),
      );
    }

    if (state.hasError) {
      return ProductErrorState(
        onRetry: onRetry,
      );
    }

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductSearchBar(
              onChanged: onSearch,
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductFilterBar(
              selectedSort: state.sort,
              onSortChanged: onSortChanged,
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            16,
            24,
            16,
            12,
          ),
          sliver: SliverToBoxAdapter(
            child: ProductSectionHeader(
              count: state.products.length,
            ),
          ),
        ),

        if (state.products.isEmpty)
          SliverToBoxAdapter(
            child: ProductEmptyState(
              message: state.searchQuery.isEmpty
                  ? 'No products available'
                  : 'No products match your search',
            ),
          )
        else
          ProductGrid(
            products: state.products,
            onAdd: (product) {
              ref
        .read(cartControllerProvider.notifier)
        .addToCart(
          productId: product.id,
          title: product.name,
          // price: product.code,
          // image: product.image,
        );
              ProductActionHandler.showMessage(
                context,
                '${product.name} added to cart',
              );
            },
            onFavorite: (product) {
              ProductActionHandler.showMessage(
                context,
                '${product.name} added to favorites',
              );
            },
          ),
      ],
    );
  }
}
