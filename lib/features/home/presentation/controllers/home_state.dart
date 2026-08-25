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
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  final HomeStatus status;

  final List<Product> allProducts;

  final List<Product> products;

  final String searchQuery;

  final ProductSort sort;

  final String? errorMessage;

  // Indicates whether the next page is being loaded.
  final bool isLoadingMore;

  // Indicates whether more products are available.
  final bool hasMore;

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
    bool? isLoadingMore,
    bool? hasMore,
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
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}