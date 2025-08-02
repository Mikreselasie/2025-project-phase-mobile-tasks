import 'package:ecommerce/features/product/data/models/product_model.dart';

abstract class RemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchProductsFromServer();
  Future<Map<String, dynamic>> fetchProductById(String id);
  Future<ProductModel> getProductById(String id);
  Future<Map<String, dynamic>> createProductOnServer(ProductModel product);
  Future<void> updateProductOnServer(ProductModel product);
  Future<void> deleteProductFromServer(String id);
  Future<List<ProductModel>> getAllProducts();
}
