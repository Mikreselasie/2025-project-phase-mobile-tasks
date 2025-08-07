import 'package:ecommerce/features/auth/data/models/log_in_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tLogInModel = LoginModel(email: "email", password: "password");
  test("Should return correct json when toJson is called", () {
    final result = tLogInModel.toJson();
    final expectedMap = {"email": "email", "password": "password"};
    expect(result, expectedMap);
  });
}
