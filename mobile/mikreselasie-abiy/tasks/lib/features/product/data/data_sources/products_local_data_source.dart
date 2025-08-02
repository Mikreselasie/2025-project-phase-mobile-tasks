import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getAllCachedProducts();
  Future<Product> getProductById(String productId);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> cacheProduct(ProductModel product);
  Future<void> saveProduct(Map<String, dynamic> productJson);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(ProductModel product);
}

const CACHED_PRODUCTS = "CACHED_PRODUCTS";

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheProduct(ProductModel product) {
    return sharedPreferences.setString(
      CACHED_PRODUCTS,
      json.encode(product.toJSON()),
    );
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final productsJsonList = products
        .map((product) => product.toJSON())
        .toList();
    final jsonString = json.encode(productsJsonList);
    final success = await sharedPreferences.setString(
      CACHED_PRODUCTS,
      jsonString,
    );

    if (!success) {
      throw const CacheException(message: 'Failed to cache products');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final productsJson = sharedPreferences.getString(CACHED_PRODUCTS);

    if (productsJson != null) {
      final productList = (jsonDecode(productsJson) as List)
          .map((e) => ProductModel.fromJSON(e))
          .toList();

      final updatedList = productList
          .where((product) => product.productId != id)
          .toList();

      final success = await sharedPreferences.setString(
        CACHED_PRODUCTS,
        json.encode(updatedList.map((e) => e.toJSON()).toList()),
      );

      if (!success) {
        throw const CacheException(message: 'Failed to update cache');
      }
    } else {
      throw const CacheException(
        message: 'No products in cache to delete from',
      );
    }
  }

  @override
  Future<List<ProductModel>> getAllCachedProducts() {
    final productsJson = sharedPreferences.getString(CACHED_PRODUCTS);
    if (productsJson != null) {
      final products = (jsonDecode(productsJson) as List)
          .map((e) => ProductModel.fromJSON(e))
          .toList();
      return Future.value(products);
    } else {
      throw const CacheException(message: 'Products not found in cache');
    }
  }

  @override
  Future<Product> getProductById(String productId) {
    final productsJson = sharedPreferences.getString(CACHED_PRODUCTS);
    if (productsJson != null) {
      final products = (jsonDecode(productsJson) as List)
          .map((e) => ProductModel.fromJSON(e))
          .toList();

      for (final product in products) {
        if (product.productId == productId) {
          return Future.value(product);
        }
      }

      throw const CacheException(message: 'Product not found in cache');
    } else {
      throw const CacheException(message: 'Products not found in cache');
    }
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> productJson) async {
    final productsJson = sharedPreferences.getString(CACHED_PRODUCTS);

    List<Map<String, dynamic>> productList = [];

    if (productsJson != null) {
      final decoded = json.decode(productsJson) as List;
      productList = decoded.cast<Map<String, dynamic>>();
    }

    productList.add(productJson);

    final success = await sharedPreferences.setString(
      CACHED_PRODUCTS,
      json.encode(productList),
    );

    if (!success) {
      throw const CacheException(message: 'Failed to save product');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final productsJson = sharedPreferences.getString(CACHED_PRODUCTS);

    if (productsJson != null) {
      final products = (jsonDecode(productsJson) as List)
          .map((e) => ProductModel.fromJSON(e))
          .toList();

      final index = products.indexWhere(
        (p) => p.productId == product.productId,
      );

      if (index == -1) {
        throw const CacheException(message: 'Product not found in cache');
      }

      products[index] = product;

      final success = await sharedPreferences.setString(
        CACHED_PRODUCTS,
        json.encode(products.map((e) => e.toJSON()).toList()),
      );

      if (!success) {
        throw const CacheException(message: 'Failed to update product');
      }
    } else {
      throw const CacheException(message: 'No products in cache to update');
    }
  }
}
