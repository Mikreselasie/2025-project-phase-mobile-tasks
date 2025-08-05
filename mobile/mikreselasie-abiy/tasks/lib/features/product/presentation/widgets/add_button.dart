import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(
        context,
        "/addUpdatePage",
        arguments: {"action": "add"},
      ),
      shape: CircleBorder(),
      backgroundColor: AppColors.secondary,
      child: Icon(Icons.add, size: 40, color: AppColors.background),
    );
  }
}
