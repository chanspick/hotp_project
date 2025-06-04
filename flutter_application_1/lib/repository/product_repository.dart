import '../models/product.dart';
import '../services/product_service.dart';

class ProductRepository {
  final ProductService _service;

  ProductRepository(this._service);

  Future<List<Product>> getProducts() {
    return _service.fetchProducts();
  }
}
