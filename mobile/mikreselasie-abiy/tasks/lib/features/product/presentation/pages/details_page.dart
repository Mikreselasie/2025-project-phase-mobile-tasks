import '../../data/models/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;

  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Image with back button
            ImageWithBackButtonDetailsPage(product: product),
            // Content
            ProductDetailsWidget(product: product),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: DetailsPageControl(product: product),
            ),
          ],
        ),
      ),
    );
  }
}
