import 'dart:convert';

import 'package:ecommerce/features/auth/data/models/authenticated_user_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/features/auth/domain/entities/authenticated_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/fixtures/fixiture_reader.dart';

void main() {
  final tUserModel = AuthenticatedUserModel(
    email: "email",
    name: "name",
    id: "id",
    accessToken: "accessToken",
  );

  test("Should be a subclass of User", () async {
    expect(tUserModel, isA<AuthenticatedUser>());
  });

  test("Should Return a vaild Model when the Json is given", () async {
    Map<String, dynamic> decodedJson = jsonDecode(fixiture("user.json"));
    final Map<String, String> jsonMap = Map<String, String>.from(decodedJson);
    final result = AuthenticatedUserModel.fromJson(jsonMap);

    expect(result, equals(tUserModel));
  });

  test("Should return a JSON map containing a proper data", () async {
    final result = tUserModel.toJson();
    final expectedMap = {
      "email": "email",
      "name": "name",
      "id": "id",
      "access_token": "accessToken",
    };

    expect(result, expectedMap);
  });
}
