import 'package:ecommerce/core/presentation/pages/home_page.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:ecommerce/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:ecommerce/features/chat/presentation/pages/inbox.dart';
import 'package:ecommerce/features/chat/presentation/pages/my_chats.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/pages/search_page.dart';
import 'package:ecommerce/features/product/presentation/pages/update_product.dart';
import 'package:ecommerce/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    GoRoute(
      path: Routes.chatInbox,
      builder: (context, state) {
        final chat = state.extra as Chat;
        return ChatInboxPage(chat: chat);
      },
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => serviceLocator<ChatsBloc>(),
          child: ChatsPage(),
        );
      },
    ),
  ],
);
