import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:ecommerce/core/presentation/widgets/snack_bar.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecommerce/features/auth/presentation/widgets/log_in_form.dart';
import 'package:ecommerce/features/auth/presentation/widgets/logo.dart';
import 'package:ecommerce/features/auth/presentation/widgets/sign_in_sign_up_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          context.go(Routes.home);
          showInfo(context, 'Logged in successfully');
        } else if (state is AuthLoginFailure) {
          showError(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Logo(textStyle: AppTextStyles.logoTextBig),
                  SizedBox(height: 40),
                  Text("Sign into your account", style: AppTextStyles.heading1),
                  SizedBox(height: 40),
                  LoginForm(),
                  const SizedBox(height: 20),
                  // Demo mode button for when server is down
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        showInfo(context, 'Demo mode activated');
                        context.go(Routes.home);
                      },
                      child: const Text('Try Demo Mode'),
                    ),
                  ),
                  SizedBox(height: 100),
                  SignInSignUpRouter(
                    firstDesc: "Don't Have an Account?",
                    secondDesc: ' SIGN UP',
                    router: () => context.go(
                      Routes.register,
                    ), // ✅ pass a function that can be called later
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
