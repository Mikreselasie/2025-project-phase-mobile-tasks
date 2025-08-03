import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> createProductOnServer(ProductModel product);
  Future<ProductModel> updateProductOnServer(ProductModel product);
  Future<void> deleteProductFromServer(String id);
  Future<List<ProductModel>> getAllProducts();
}
