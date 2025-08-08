import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsCheckbox extends StatefulWidget {
  @override
  _TermsCheckboxState createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'I understood the ',
                  style: AppTextStyles.terms_text,
                ),
                TextSpan(
                  text: 'terms & policies.',
                  style: AppTextStyles.link_text,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Open terms link
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
