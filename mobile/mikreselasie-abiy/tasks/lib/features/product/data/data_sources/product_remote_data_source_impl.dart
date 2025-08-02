import 'dart:convert';

import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String _baseUrl;

  ProductRemoteDataSourceImpl({required this.client})
    : _baseUrl = '$baseUrl/products';

  @override
  Future<ProductModel> createProductOnServer(ProductModel product) async {
    try {
      final response = await client.post(
        Uri.parse(_baseUrl),
        body: jsonEncode(product.toJson()),
        headers: defaultHeaders,
      );

      if (response.statusCode == 201) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteProductFromServer(String id) async {
    try {
      final response = await client.delete(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode != 200) {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> fetchProductById(String id) async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> products = jsonDecode(response.body);
        return products.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> updateProductOnServer(ProductModel product) async {
    try {
      final response = await client.put(
        Uri.parse('$_baseUrl/${product.id}'),
        body: jsonEncode(product.toJson()),
        headers: defaultHeaders,
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
