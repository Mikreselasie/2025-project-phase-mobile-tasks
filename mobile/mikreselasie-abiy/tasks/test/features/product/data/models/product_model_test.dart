import 'dart:convert';

import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/fixtures/fixiture_reader.dart';

void main() {
  final tProductModel = ProductModel(
    name: "HP Victus 15",
    description: "Personal computer",
    price: 123.45,
    imageUrl:
        "https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png",
    id: "acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b",
  );

  test("Should be a subclass of product", () async {
    expect(tProductModel, isA<Product>());
  });

  test("Should Return a vaild Model when the Json is given", () async {
    final Map<String, dynamic> jsonMap = json.decode(fixiture("product.json"));
    final result = ProductModel.fromJson(jsonMap);

    expect(result, equals(tProductModel));
  });

  test("Should return a JSON map containing a proper data", () async {
    final result = tProductModel.toJson();
    final expectedMap = {
      "name": "HP Victus 15",
      "description": "Personal computer",
      "price": 123.45,
      "imageUrl":
          "https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png",
      "id": "acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b",
    };

    expect(result, expectedMap);
  });
}
