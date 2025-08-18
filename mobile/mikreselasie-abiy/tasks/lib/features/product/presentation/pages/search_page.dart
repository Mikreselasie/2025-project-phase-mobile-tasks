import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/widgets/input_inserted.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_card.dart';
import 'package:ecommerce/features/product/presentation/widgets/search_page_bottom.dart';
import 'package:ecommerce/features/product/presentation/widgets/update_add_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Column(
            children: [
              // Header
              const SizedBox(height: 20),
              UpdateAddTop(word: "Search Products"),
              // Search Input
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: InputInserted(
                      height: 48,
                      controller: _searchController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
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
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Results
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
      bottomNavigationBar: SearchPageBottom(),
    );
  }
}
