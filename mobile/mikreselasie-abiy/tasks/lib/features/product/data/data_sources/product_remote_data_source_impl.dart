import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/data_sources/products_remote_data_source.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/http.dart';

class ProductRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final HttpClient client;
  final String _baseUrl;

  ProductRemoteDataSourceImpl({required this.client})
    : _baseUrl = '$baseUrl/products';

  @override
  Future<ProductModel> createProductOnServer(ProductModel product) async {
    try {
      final response = await client.uploadFile(
        _baseUrl,
        HttpMethod.post,
        {
          'name': product.name,
          'description': product.description,
          'price': product.price.toString(),
        },
        [UploadFile(key: 'image', path: product.imageUrl)],
      );

      if (response.statusCode == 201) {
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.reasonPhrase);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteProductFromServer(String id) async {
    try {
      final response = await client.delete('$_baseUrl/$id');

      if (response.statusCode != 200) {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await client.get('$_baseUrl/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
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
      final response = await client.get(_baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> products = jsonDecode(response.body)['data'];
        return products.map((e) => ProductModel.fromJson(e)).toList();
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
        '$_baseUrl/${product.id}',
        product.toJson(),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
