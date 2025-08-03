import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'products_local_data_source.dart';

const String _cachedProductsKey = "CACHED_PRODUCTS";

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  // Helper: Load product list from cache
  List<ProductModel> _loadCachedProducts() {
    final jsonString = sharedPreferences.getString(_cachedProductsKey);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List;
      return decodedList.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw const CacheException(message: 'No products found in cache');
    }
  }

  // Helper: Save product list to cache
  Future<void> _saveProductsToCache(List<ProductModel> products) async {
    final success = await sharedPreferences.setString(
      _cachedProductsKey,
      jsonEncode(products.map((e) => e.toJson()).toList()),
    );

    if (!success) {
      throw const CacheException(message: 'Failed to save products');
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final currentProducts = _loadCachedProducts();
    currentProducts.add(product);
    await _saveProductsToCache(currentProducts);
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await _saveProductsToCache(products);
  }

  @override
  Future<void> deleteProduct(String id) async {
    final products = _loadCachedProducts();
    final updated = products.where((product) => product.id != id).toList();

    if (updated.length == products.length) {
      throw const CacheException(message: 'Product not found in cache');
    }

    await _saveProductsToCache(updated);
  }

  @override
  Future<List<ProductModel>> getAllCachedProducts() async {
    return _loadCachedProducts();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final products = _loadCachedProducts();
    final product = products.firstWhere(
      (product) => product.id == id,
      orElse: () => throw const CacheException(message: 'Product not found'),
    );
    return product;
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> productJson) async {
    final products = _loadCachedProducts();
    products.add(ProductModel.fromJson(productJson));
    await _saveProductsToCache(products);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final products = _loadCachedProducts();
    final index = products.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      throw const CacheException(message: 'Product not found in cache');
    }

    products[index] = product;
    await _saveProductsToCache(products);
  }
}
