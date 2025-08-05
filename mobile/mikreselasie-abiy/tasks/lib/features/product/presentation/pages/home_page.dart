import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load all products when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadAllProductEvent());
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade700, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/person.png",
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("July 14, 2023", style: AppTextStyles.dateText),
                        Row(
                          children: [
                            Text(
                              "Hello, ",
                              style: AppTextStyles.welcomeTextHello,
                            ),
                            Text(
                              "Yohannes",
                              style: AppTextStyles.welcomeTextName,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconsBox(
                    child: Icon(
                      Icons.notifications_on,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Available Products", style: AppTextStyles.bigheading),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/searchPage"),
                    child: IconsBox(
                      child: Icon(Icons.search, color: AppColors.borderPrimary),
                    ),
                  ),
                ],
              ),
            ),

            // BlocBuilder to respond to state changes
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoadedAllProductState) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(child: Text("No products available."));
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(product: product);
                      },
                    );
                  } else if (state is ErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text("Something went wrong."));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(),
    );
  }
}
