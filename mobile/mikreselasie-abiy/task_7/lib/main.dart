import 'package:flutter/material.dart';
import 'package:task_7/home_page.dart';
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
    );
  }
}
