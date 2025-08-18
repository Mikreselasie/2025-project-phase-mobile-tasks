import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/core/presentation/widgets/input.dart';
import 'package:ecommerce/features/product/presentation/widgets/input_type_name.dart';
import 'package:ecommerce/features/product/presentation/widgets/price_range_slider.dart';
import 'package:flutter/material.dart';

class SearchPageBottom extends StatelessWidget {
  const SearchPageBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 18, 25, 25),
      child: SizedBox(
        height: 255,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(label: "Category", controller: TextEditingController()),

            InputTypeName(name: "Price"),
            PriceRangeSlider(
              min: 0,
              max: 1000,
              initialRange: RangeValues(100, 600),
              onChanged: (range) {},
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("APPLY", style: AppTextStyles.blueButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
