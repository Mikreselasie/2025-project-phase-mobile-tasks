import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class ImageWithBackButtonDetailsPage extends StatelessWidget {
  const ImageWithBackButtonDetailsPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(product.imageUrl),
        Positioned(
          left: 20,
          top: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
              height: 40,
              width: 40,
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
