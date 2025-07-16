import 'package:flutter/material.dart';

/// App-wide color palette
class AppColors {
  static const Color primary = Color(0xFF0D47A1); // Deep Blue
  static const Color secondary = Color.fromARGB(
    255,
    63,
    81,
    243,
  ); // Lighter Blue
  static const Color accent = Color(0xFFFFC107); // Amber
  static const Color background = Color(0xFFF5F5F5); // Light Gray
  static const Color textPrimary = Color(0xFF212121); // Dark Gray
  static const Color textSecondary = Color(0xFFAAAAAA); // Medium Gray
  static const Color border = Color(0xFFBDBDBD); // Light Border Gray
  static const Color error = Color(0xFFFF0000);
  static const Color borderPrimary = Color(0xD9D9D9D9); // Red
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
    fontSize: 14,
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
  static const TextStyle descriptionPageCategoryShow = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Poppins',
  );

  static const TextStyle cardProductName = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
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
    color: AppColors.textSecondary,
  );
  static const TextStyle dateText = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle welcomeTextHello = TextStyle(
    fontSize: 15,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w900,
    color: AppColors.textSecondary,
  );
  static const TextStyle welcomeTextName = TextStyle(
    fontSize: 15,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );
  static const TextStyle priceText = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const TextStyle addProductText = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const TextStyle deleteButton = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',

    color: AppColors.error,
  );
  static const TextStyle updateButton = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',

    color: AppColors.background,
  );
}

class IconsBox extends StatelessWidget {
  final Widget child;

  const IconsBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: child,
      height: 40,
      width: 40,
    );
  }
}

class InputInserted extends StatelessWidget {
  final double? height;

  const InputInserted({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          height ??
          50, // Use Container instead of SizedBox for more flexibility
      child: TextField(
        expands: true, // <- This makes TextField expand to the parent's height
        maxLines: null, // Required when using expands
        minLines: null, // Required when using expands
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.borderPrimary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

class InputTypeName extends StatelessWidget {
  const InputTypeName({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Text('$name', style: AppTextStyles.bodyText),
    );
  }
}
