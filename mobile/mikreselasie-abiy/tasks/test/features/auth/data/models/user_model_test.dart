import 'dart:convert';

import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/fixtures/fixiture_reader.dart';

void main() {
  final UserModel tUserModel = UserModel(
    id: "id",
    email: "email",
    name: "name",
  );

  test("Should extract the Json exactly", () {
    Map<String, dynamic> jsonData = json.decode(fixiture("user_model.json"));
    Map<String, String> expextedData = Map<String, String>.from(jsonData);
    final result = UserModel.fromJson(expextedData);

    expect(result, equals(tUserModel));
  });
}
