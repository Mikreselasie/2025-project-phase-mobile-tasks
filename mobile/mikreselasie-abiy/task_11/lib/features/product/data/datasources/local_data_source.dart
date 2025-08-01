abstract class LocalDataSource {
  Future<List<Map<String, dynamic>>> getCachedProducts();
  Future<void> cacheProducts(List<Map<String, dynamic>> products);
  Future<void> saveProduct(Map<String, dynamic> productJson);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(Map<String, dynamic> updatedProductJson);
}
