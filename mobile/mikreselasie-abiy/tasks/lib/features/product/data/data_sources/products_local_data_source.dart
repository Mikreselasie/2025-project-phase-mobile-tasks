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
