import '../../domain/entities/product.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

enum ProductSort {
  nameAscending,
  nameDescending,
}

class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.allProducts = const [],
    this.products = const [],
    this.searchQuery = '',
    this.sort = ProductSort.nameAscending,
    this.errorMessage,
  });

  final HomeStatus status;

  /// Original products received from API.
  final List<Product> allProducts;

  /// Filtered/sorted products displayed by UI.
  final List<Product> products;

  final String searchQuery;

  final ProductSort sort;

  final String? errorMessage;

  bool get isLoading => status == HomeStatus.loading;

  bool get hasError => status == HomeStatus.error;

  bool get isEmpty => products.isEmpty;

  HomeState copyWith({
    HomeStatus? status,
    List<Product>? allProducts,
    List<Product>? products,
    String? searchQuery,
    ProductSort? sort,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      sort: sort ?? this.sort,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}