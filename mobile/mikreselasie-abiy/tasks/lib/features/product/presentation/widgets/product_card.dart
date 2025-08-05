import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

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
    final imageWidget = Image.network(
      product.imageUrl,
      fit: BoxFit.cover,
      height: 160,
      width: 366,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error); // Show error icon if image fails to load
      },
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
                        product
                            .name, // Showing price directly without formatting
                        style: AppTextStyles.cardCategoryText,
                      ),
                      Text('⭐ 4.0', style: AppTextStyles.cardCategoryText),
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
