import 'package:ecommerce/features/product/presentation/widgets/update_add_top.dart';

import '../../../../core/presentation/routers/app_routes.dart';
import '../../../../core/presentation/widgets/snack_bar.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../widgets/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductsAddSuccess) {
          context.go(Routes.home);
          showInfo(context, 'Product added successfully');
        } else if (state is ProductUpdateSuccess) {
          context.go(Routes.home);
          showInfo(context, 'Product updated successfully');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                UpdateAddTop(word: "Add Product"),
                SizedBox(height: 30),
                const SingleChildScrollView(child: ProductForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
