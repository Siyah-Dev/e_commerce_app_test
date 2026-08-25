import 'package:e_commerce_test/features/home/presentation/controllers/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';
import '../providers/home_providers.dart';


class HomeController extends Notifier<HomeState> {
  @override
  HomeState build() {
    Future.microtask(loadProducts);

    return const HomeState();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(
      status: HomeStatus.loading,
      clearError: true,
    );

    try {
      final products = await ref
          .read(homeRepositoryProvider)
          .getProducts();

      state = state.copyWith(
        status: HomeStatus.success,
        allProducts: products,
        products: _filterAndSort(
          products: products,
          query: state.searchQuery,
          sort: state.sort,
        ),
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        status: HomeStatus.error,
        errorMessage: _getErrorMessage(error),
      );
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts();
  }

  void searchProducts(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    state = state.copyWith(
      searchQuery: normalizedQuery,
      products: _filterAndSort(
        products: state.allProducts,
        query: normalizedQuery,
        sort: state.sort,
      ),
    );
  }

  void sortProducts(ProductSort sort) {
    state = state.copyWith(
      sort: sort,
      products: _filterAndSort(
        products: state.allProducts,
        query: state.searchQuery,
        sort: sort,
      ),
    );
  }

  List<Product> _filterAndSort({
    required List<Product> products,
    required String query,
    required ProductSort sort,
  }) {
    final filteredProducts = products.where(
      (product) {
        if (query.isEmpty) {
          return true;
        }

        final name = product.name.toLowerCase();
        final code = product.code.toLowerCase();
        final barcode = product.barcode.toLowerCase();

        return name.contains(query) ||
            code.contains(query) ||
            barcode.contains(query);
      },
    ).toList();

    filteredProducts.sort(
      (first, second) {
        final comparison = first.name.compareTo(
          second.name,
        );

        return sort == ProductSort.nameAscending
            ? comparison
            : -comparison;
      },
    );

    return filteredProducts;
  }

  String _getErrorMessage(Object error) {
    return 'Unable to load products. Please try again.';
  }
}