import '../models/product_model.dart';
import '../../domain/entities/product.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getAllCachedProducts();
  Future<Product> getProductById(String productId);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> cacheProduct(ProductModel product);
  Future<void> saveProduct(Map<String, dynamic> productJson);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(ProductModel product);
}
