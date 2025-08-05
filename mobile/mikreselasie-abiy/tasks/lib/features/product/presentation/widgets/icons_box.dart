import 'package:flutter/material.dart';

import '../constants/constants.dart';

class IconsBox extends StatelessWidget {
  final Widget child;

  const IconsBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: child,
      height: 40,
      width: 40,
    );
  }
}
