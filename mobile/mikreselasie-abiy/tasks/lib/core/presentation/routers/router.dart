import 'package:ecommerce/core/presentation/pages/home_page.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/pages/search_page.dart';
import 'package:ecommerce/features/product/presentation/pages/update_product.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/auth/presentation/pages/sign_up_page.dart';
import '../../../features/auth/presentation/pages/splash_screen.dart';
import '../../../features/product/domain/entities/product.dart';
import '../../../features/product/presentation/pages/pages.dart';

import 'app_routes.dart';

final router = GoRouter(
  routes: <RouteBase>[
    //
    GoRoute(
      path: Routes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),

    //
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),

    //
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const RegisterPage(),
    ),

    //
    GoRoute(path: Routes.home, builder: (context, state) => HomePage()),

    //
    GoRoute(
      path: Routes.productDetail,
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return DetailsPage(product: product);
      },
    ),

    //
    GoRoute(
      path: Routes.addProduct,
      builder: (context, state) => const AddProductPage(),
    ),

    //
    GoRoute(
      path: Routes.updateProduct,
      builder: (context, state) {
        final product = state.extra as Product;
        return UpdateProductPage(product: product);
      },
    ),

    //
    GoRoute(
      path: Routes.searchProduct,
      builder: (context, state) => const SearchPage(),
    ),
  ],
);
