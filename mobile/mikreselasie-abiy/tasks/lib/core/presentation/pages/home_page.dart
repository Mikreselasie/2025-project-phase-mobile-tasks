import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:ecommerce/core/presentation/widgets/add_button.dart';
import 'package:ecommerce/core/presentation/widgets/icons_box.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load all products when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(ProductsLoadRequested());
    });

    return Scaffold(
      backgroundColor: Colors.white,
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
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final date = DateFormat(
                              'MMMM d, y',
                            ).format(DateTime.now());

                            String name = "Guest";

                            if (state is AuthSuccess) {
                              name = state.user.name;
                            } else if (state is AuthLoadSuccess) {
                              name = state.user.name;
                            } else if (state is AuthLoginSuccess) {
                              name = state.user.name;
                            } else if (state is AuthRegisterSuccess) {
                              name = state.user.name;
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(date, style: AppTextStyles.dateText),
                                Row(
                                  children: [
                                    Text(
                                      "Hello, ",
                                      style: AppTextStyles.welcomeTextHello,
                                    ),
                                    Text(
                                      name,
                                      style: AppTextStyles.welcomeTextName,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(Routes.chats);
                    },
                    child: IconsBox(
                      child: Icon(
                        Icons.notifications_on,
                        color: AppColors.textPrimary,
                      ),
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
                    onTap: () {
                      // TODO: Implement search functionality
                      context.push(Routes.searchProduct);
                    },
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
