import 'package:ecommerce/core/presentation/routers/router.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/core/presentation/bloc/simple_bloc_observer.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  await di.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) =>
              di.serviceLocator<ProductBloc>()..add(ProductsLoadRequested()),
        ),
        BlocProvider(
          create: (context) =>
              di.serviceLocator<AuthBloc>()..add(const AuthLoadRequested()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Products',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF3E50F3),
            secondary: Color(0xFF0C8CE9),
            surface: Color(0xFFF1EEEE),
            error: Color(0xFFB00020),
            onPrimary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFFFFFFFF),
            onSurface: Color(0xFF000000),
            onError: Color(0xFFFFFFFF),
          ),

          //
          //! Font
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),

        //
        debugShowCheckedModeBanner: false,

        routerConfig: router,
      ),
    );
  }
}
