import 'dart:ui';

import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInSignUpRouter extends StatelessWidget {
  const SignInSignUpRouter({
    super.key,
    required this.firstDesc,
    required this.secondDesc,
    this.router,
  });

  final String firstDesc;
  final String secondDesc;
  final VoidCallback? router;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(text: firstDesc, style: AppTextStyles.toggleText),
          TextSpan(
            text: secondDesc,
            style: AppTextStyles.toggleTextLink,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (router != null) {
                  router!();
                }
              },
          ),
        ],
      ),
    );
  }
}
