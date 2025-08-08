import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a timeout to prevent infinite loading - reduced to 3 seconds for faster response
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        print('SplashScreen: Timeout reached, navigating to login');
        context.push(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadSuccess) {
              context.push(Routes.home);
            } else if (state is AuthLoadFailure || state is AuthFailure) {
              context.push(Routes.login);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Loading...'),
              const SizedBox(height: 8),
              Text(
                'If the app takes too long, the server might be down.',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
