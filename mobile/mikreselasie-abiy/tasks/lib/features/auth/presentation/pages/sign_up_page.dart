import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:ecommerce/core/presentation/routers/router.dart';
import 'package:ecommerce/core/presentation/widgets/snack_bar.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecommerce/features/auth/presentation/widgets/logo.dart';
import 'package:ecommerce/features/auth/presentation/widgets/register_form.dart';
import 'package:ecommerce/features/auth/presentation/widgets/sign_in_sign_up_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          context.go(Routes.login);
          showInfo(context, 'Registered successfully');
        } else if (state is AuthRegisterFailure) {
          showError(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(35.0),

              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.go(Routes.login);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: AppColors.primary,
                          ),
                        ),
                        Logo(textStyle: AppTextStyles.logoText),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text("Create your account", style: AppTextStyles.heading1),
                    SizedBox(height: 20),
                    SingleChildScrollView(child: RegisterForm()),
                    SizedBox(height: 70),
                    SignInSignUpRouter(
                      firstDesc: "Have an account?",
                      secondDesc: " SIGN IN",
                      router: () => context.go(Routes.login),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
