import 'package:flutter/material.dart';
import 'package:task_6/constants.dart';
import 'package:task_6/helpers/product_category.dart';
import 'package:task_6/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    this.imageAspectRatio = 16 / 6,
    required this.product,
    Key? key,
  }) : assert(imageAspectRatio > 0),
       super(key: key);

  final double imageAspectRatio;
  final Product product;

  static const kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.asset(product.imageURL, fit: BoxFit.cover);

    return Card(
      margin: EdgeInsets.all(10),
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
                      style: theme.textTheme.labelLarge,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text("\$${product.price}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.productCategory.displayName}', // Showing price directly without formatting
                      style: theme.textTheme.bodySmall,
                    ),
                    Text('⭐ (${product.rating.value})'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
