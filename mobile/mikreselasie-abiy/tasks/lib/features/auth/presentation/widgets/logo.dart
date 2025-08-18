import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.textStyle});
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      alignment: Alignment.center,
      child: Text("ECOM", style: textStyle),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.primary, // Border color
          width: 1, // Border width
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 4), // Shadow position
          ),
        ],
        // Optional: rounded corners
      ),
    );
  }
}
