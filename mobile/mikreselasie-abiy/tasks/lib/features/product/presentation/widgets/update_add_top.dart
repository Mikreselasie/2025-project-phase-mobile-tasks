import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateAddTop extends StatelessWidget {
  final word;
  const UpdateAddTop({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.go(Routes.home),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        Expanded(
          child: Center(child: Text(word, style: AppTextStyles.bigheading)),
        ),
      ],
    );
  }
}
