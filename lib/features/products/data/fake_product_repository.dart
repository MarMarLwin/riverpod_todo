// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/constants/test_product.dart';
import 'package:riverpod_todo/features/products/domain/product.dart';
import 'package:riverpod_todo/utils/in_memory_store.dart';
part 'fake_product_repository.g.dart';

class FakeProductRepository {
  final bool addDelay;
  FakeProductRepository({
    required this.addDelay,
  });

  /// Preload with the default list of products when the app starts
  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));

  List<Product> getProductList() => _products.value;

  Product? getProduct(String id) => _getProduct(_products.value, id);

  Future<List<Product>> fetchProductList() async {
    return Future.value(_products.value);
  }

  Stream<List<Product>> watchProductList() {
    return _products.stream;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => _getProduct(products, id));
  }

  static Product? _getProduct(List<Product> productList, String id) {
    try {
      return productList.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
FakeProductRepository productsRepository(ProductsRepositoryRef ref) {
  // * Set addDelay to false for faster loading
  return FakeProductRepository(addDelay: false);
}

@riverpod
Future<List<Product>> productsListFuture(ProductsListFutureRef ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductList();
}

@riverpod
Stream<List<Product>> productsListStream(ProductsListStreamRef ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductList();
}

@riverpod
Stream<Product?> product(ProductRef ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}
