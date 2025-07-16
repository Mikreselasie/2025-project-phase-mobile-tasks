import 'package:flutter/material.dart';
import 'package:task_6/constants.dart';
import 'package:task_6/helpers/product_category.dart';
import 'package:task_6/product.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(product.imageURL),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background,
                  ),
                  margin: EdgeInsets.all(20),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.productCategory.displayName),
                      Text("⭐(${product.rating.value})"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(product.name), Text('\$${product.price}')],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text("Size: "),
                  ),

                  SizedBox(
                    height:
                        80, // Height enough to accommodate Container + shadow
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7, // Numbers 39 to 45 inclusive
                      itemBuilder: (context, index) {
                        final number = 39 + index;
                        return Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.all(8), // spacing between items
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 6),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
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
