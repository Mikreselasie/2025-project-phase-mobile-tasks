import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:ecommerce/core/presentation/widgets/snack_bar.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/widgets/update_add_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product.dart';
import '../widgets/product_form.dart';

class UpdateProductPage extends StatelessWidget {
  final Product product;

  const UpdateProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductUpdateSuccess) {
          context.go(Routes.home);
          showInfo(context, 'Product updated successfully');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                UpdateAddTop(word: "Update Product"),
                SizedBox(height: 30),
                SingleChildScrollView(child: ProductForm(product: product)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
