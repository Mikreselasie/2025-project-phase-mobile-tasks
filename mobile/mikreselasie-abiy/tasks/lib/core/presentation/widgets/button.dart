import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color? color;
  final ButtonStyle? style;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(text, style: AppTextStyles.blueButton),
    );
  }
}
