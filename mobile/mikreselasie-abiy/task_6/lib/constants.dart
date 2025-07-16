import 'package:flutter/material.dart';

/// App-wide color palette
class AppColors {
  static const Color primary = Color(0xFF0D47A1); // Deep Blue
  static const Color secondary = Color(0xFF1976D2); // Lighter Blue
  static const Color accent = Color(0xFFFFC107); // Amber
  static const Color background = Color(0xFFF5F5F5); // Light Gray
  static const Color textPrimary = Color(0xFF212121); // Dark Gray
  static const Color textSecondary = Color(0xFFAAAAAA); // Medium Gray
  static const Color border = Color(0xFFBDBDBD); // Light Border Gray
  static const Color error = Color(0xFFD32F2F); // Red
}

/// App-wide text styles
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle bigheading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle heading2grey = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    fontFamily: 'Poppins',
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Poppins',
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static const TextStyle cardProductName = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle cardPriceText = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle cardCategoryText = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle dateText = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
