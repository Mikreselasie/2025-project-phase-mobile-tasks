import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/errors/exceptions.dart';

import 'products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String _baseUrl;

  ProductRemoteDataSourceImpl({required this.client})
    : _baseUrl = '$baseUrl/products';

  Future<http.Response> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  T _parseJson<T>(String responseBody, T Function(dynamic) fromJson) {
    final decoded = jsonDecode(responseBody);
    return fromJson(decoded);
  }

  @override
  Future<ProductModel> createProductOnServer(ProductModel product) async {
    final response = await _sendRequest(
      () => client.post(
        Uri.parse(_baseUrl),
        headers: defaultHeaders,
        body: jsonEncode(product.toJson()),
      ),
    );

    return _parseJson(response.body, (json) => ProductModel.fromJson(json));
  }

  @override
  Future<ProductModel> updateProductOnServer(ProductModel product) async {
    final response = await _sendRequest(
      () => client.put(
        Uri.parse('$_baseUrl/${product.id}'),
        headers: defaultHeaders,
        body: jsonEncode(product.toJson()),
      ),
    );

    return _parseJson(response.body, (json) => ProductModel.fromJson(json));
  }

  @override
  Future<void> deleteProductFromServer(String id) async {
    await _sendRequest(() => client.delete(Uri.parse('$_baseUrl/$id')));
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await _sendRequest(
      () => client.get(Uri.parse('$_baseUrl/$id')),
    );

    return _parseJson(response.body, (json) => ProductModel.fromJson(json));
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await _sendRequest(() => client.get(Uri.parse(_baseUrl)));

    return _parseJson(response.body, (json) {
      return (json as List).map((e) => ProductModel.fromJson(e)).toList();
    });
  }

  // Removed fetchProductById (redundant with getProductById)
}
