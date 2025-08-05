import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Category and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.descriptionPageCategoryShow,
                  ),
                  Text(
                    "⭐ 4.0",
                    style: AppTextStyles.descriptionPageCategoryShow,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Name and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name, style: AppTextStyles.bigheading),
                  Text('\$${product.price}', style: AppTextStyles.priceText),
                ],
              ),

              const SizedBox(height: 20),

              // Size selection mock
              const SizedBox(height: 20),

              // Description
              Text(product.description, style: AppTextStyles.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
