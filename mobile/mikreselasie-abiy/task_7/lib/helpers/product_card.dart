import 'package:flutter/material.dart';
import 'package:task_7/constants.dart';
import 'package:task_7/details_page.dart';
import 'package:task_7/helpers/product_category.dart';
import 'package:task_7/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    this.imageAspectRatio = 366 / 160,
    required this.product,
    Key? key,
  }) : assert(imageAspectRatio > 0),
       super(key: key);

  final double imageAspectRatio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.asset(
      product.imageURL,
      fit: BoxFit.cover,
      height: 160,
      width: 366,
    );

    return Card(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/details", arguments: product);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: imageAspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.directional(
                  topStart: Radius.circular(15),
                  topEnd: Radius.circular(15),
                ),
                child: imageWidget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.cardProductName,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "\$${product.price}",
                        style: AppTextStyles.cardPriceText,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.productCategory.displayName}', // Showing price directly without formatting
                        style: AppTextStyles.cardCategoryText,
                      ),
                      Text(
                        '⭐ (${product.rating.value})',
                        style: AppTextStyles.cardCategoryText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
