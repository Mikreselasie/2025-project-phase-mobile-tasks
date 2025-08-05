import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/pages/add_update_page.dart';
import 'package:ecommerce/features/product/presentation/pages/details_page.dart';
import 'package:ecommerce/features/product/presentation/pages/home_page.dart';
import 'package:ecommerce/features/product/presentation/pages/search_page.dart';
import 'package:ecommerce/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => sl<ProductBloc>(), // ✅ Use the GetIt factory
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "/searchPage": (context) => const SearchPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/details') {
            final product = settings.arguments as ProductModel;
            return MaterialPageRoute(
              builder: (context) => DetailsPage(product: product), // ✅ fix
            );
          } else if (settings.name == '/addUpdatePage') {
            final args = settings.arguments;
            if (args is Map<String, dynamic>) {
              return MaterialPageRoute(
                builder: (context) => const AddUpdatePage(),
                settings: RouteSettings(
                  arguments: args,
                ), // pass args to the page
              );
            } else {
              // Handle missing or invalid arguments
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Invalid or missing arguments')),
                ),
              );
            }
          }

          return null;
        },
      ),
    );
  }
}
