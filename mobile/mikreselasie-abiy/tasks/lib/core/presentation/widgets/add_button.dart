import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routers/app_routes.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push(Routes.addProduct),
      shape: CircleBorder(),
      backgroundColor: AppColors.secondary,
      child: Icon(Icons.add, size: 40, color: AppColors.background),
    );
  }
}
