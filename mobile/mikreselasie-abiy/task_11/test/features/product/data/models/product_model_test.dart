import 'dart:convert';

import 'package:domain_layer_refactor/features/product/data/models/product_model.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../../../core/fixtures/fixiture_reader.dart';

void main() {
  final tProductModel = ProductModel(
    name: "Shoe",
    description: "Good Shoe",
    price: 123.45,
    imageURL: "https://product.image.com/id",
    productId: "shoe1",
  );

  test("Should be a subclass of product", () async {
    expect(tProductModel, isA<Product>());
  });

  test("Should Return a vaild Model when the Json is given", () async {
    final Map<String, dynamic> jsonMap = json.decode(fixiture("product.json"));
    final result = ProductModel.fromJSON(jsonMap);

    expect(result, equals(tProductModel));
  });

  test("Should return a JSON map containing a proper data", () async {
    final result = tProductModel.toJSON();
    final expectedMap = {
      "name": "Shoe",
      "description": "Good Shoe",
      "price": 123.45,
      "imageURL": "https://product.image.com/id",
      "productId": "shoe1",
    };

    expect(result, expectedMap);
  });
}
