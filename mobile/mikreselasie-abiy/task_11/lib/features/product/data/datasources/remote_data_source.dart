abstract class RemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchProductsFromServer();
  Future<Map<String, dynamic>> fetchProductById(String id);
  Future<Map<String, dynamic>> createProductOnServer(
    Map<String, dynamic> product,
  );
  Future<void> updateProductOnServer(Map<String, dynamic> product);
  Future<void> deleteProductFromServer(String id);
}
