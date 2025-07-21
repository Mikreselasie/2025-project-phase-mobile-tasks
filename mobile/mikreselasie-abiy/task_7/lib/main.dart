import 'package:flutter/material.dart';
import 'package:task_7/add_update_page.dart';
import 'package:task_7/details_page.dart';
import 'package:task_7/home_page.dart';
import 'package:task_7/product.dart';
import 'package:task_7/search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/searchPage": (context) => SearchPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/details') {
          final product = settings.arguments as Product;

          return MaterialPageRoute(
            builder: (context) => DetailsPage(product: product),
          );
        } else if (settings.name == '/addUpdatePage') {
          final product = settings.arguments as String;

          return MaterialPageRoute(
            builder: (context) => AddUpdatePage(pageType: product),
          );
        }
        // return a default/fallback page if needed
        return null;
      },
    );
  }
}
