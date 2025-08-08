import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/input.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Input(
            label: 'Email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email';
              }
              return null;
            },
            hint: "  ex. jon.smith@gmail.com",
          ),
          const SizedBox(height: 10),
          Input(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password';
              }
              return null;
            },
            hint: "  ***********",
          ),
          const SizedBox(height: 40),

          //
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoginInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Button(
                  text: 'SIGN IN',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.secondary,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    context.read<AuthBloc>().add(
      AuthLoginRequested(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
