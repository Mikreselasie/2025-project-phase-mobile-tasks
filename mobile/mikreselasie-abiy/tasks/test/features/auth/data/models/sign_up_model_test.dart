import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tUser = SignUpModel(password: "password", email: "email", name: "name");

  test("Should return a proper json from toJson", () {
    final expectedMap = {
      "name": "name",
      "email": "email",
      "password": "password",
    };
    expect(tUser.toJson(), expectedMap);
  });
}
