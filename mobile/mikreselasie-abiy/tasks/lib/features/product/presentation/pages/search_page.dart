import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:ecommerce/features/product/presentation/widgets/input_inserted.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Search Product",
                        style: AppTextStyles.addProductText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search input field (no logic attached yet)
              Row(
                children: [
                  const Expanded(child: InputInserted(height: 48)),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: AppColors.background,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Products List
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedAllProductState) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text("No products found."));
                      }
                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      );
                    } else if (state is ErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text("No data."));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
