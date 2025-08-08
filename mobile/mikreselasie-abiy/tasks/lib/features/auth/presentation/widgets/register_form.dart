import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecommerce/features/auth/presentation/widgets/terms_checkbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/input.dart';
import '../bloc/auth_bloc.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Input(
            label: 'Name',
            hint: 'Enter your name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Input(
            label: 'Email',
            hint: 'Enter your email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Input(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
            hint: 'Enter your password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Input(
            label: 'Confirm Password',
            controller: _passwordController,
            isPassword: true,
            hint: 'Enter your password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TermsCheckbox(),
          //
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoginInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Button(
                  text: 'SIGN UP',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register(context);
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
                  color: AppColors.background,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) {
    context.read<AuthBloc>().add(
      AuthRegisterRequested(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
