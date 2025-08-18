import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../../../../core/presentation/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPageControl extends StatelessWidget {
  const DetailsPageControl({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // DELETE
        SizedBox(
          width: 152,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProductEvent(product.id));
              context.go(Routes.home);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.red, width: 1),
            ),
            child: Text("DELETE", style: AppTextStyles.deleteButton),
          ),
        ),

        // UPDATE
        SizedBox(
          width: 152,
          height: 50,
          child: TextButton(
            onPressed: () {
              context.go(Routes.updateProduct, extra: product);
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("UPDATE", style: AppTextStyles.blueButtonDetails),
          ),
        ),
      ],
    );
  }
}
