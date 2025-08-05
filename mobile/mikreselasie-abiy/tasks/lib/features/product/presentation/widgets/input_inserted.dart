import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class InputInserted extends StatelessWidget {
  final double? height;
  final controller;

  const InputInserted({super.key, this.height, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          height ??
          50, // Use Container instead of SizedBox for more flexibility
      child: TextField(
        expands: true, // <- This makes TextField expand to the parent's height
        maxLines: null, // Required when using expands
        minLines: null,
        controller: controller, // Required when using expands
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.borderPrimary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
