import 'product.dart';
import 'package:task_6/helpers/product_category.dart';
import 'helpers/rating.dart';

class ProductManager {
  final List<Product> _products = [
    Product(
      name: "Leather Shoe",
      description:
          "Classic leather shoe with a sleek design, perfect for formal or smart-casual wear.",
      price: 50.0,
      rating: Rating.good,
      imageURL: 'assets/shoe_2.jpg',
      productCategory: ProductCategory.shoes,
    ),
    Product(
      name: "Casual Sneakers",
      description:
          "Comfortable sneakers for daily wear, stylish and versatile.",
      price: 40.0,
      rating: Rating.average,
      imageURL: 'assets/shoe_1.jpg',
      productCategory: ProductCategory.shoes,
    ),
  ];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    print('Product "${product.name}" added successfully.\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.\n');
      return;
    }
    for (var product in _products) {
      print('${product.name}:\n$product\n');
    }
  }

  int howManyProducts() {
    return _products.length;
  }

  void viewProductByName(String name) {
    final product = _findProductByName(name);
    if (product != null) {
      print('Product Found:\n$product\n');
    } else {
      print('Product "$name" not found.\n');
    }
  }

  void editProductByName(
    String name, {
    String? newName,
    String? newDescription,
    double? newPrice,
  }) {
    final product = _findProductByName(name);
    if (product != null) {
      if (newName != null) product.name = newName;
      if (newDescription != null) product.description = newDescription;
      if (newPrice != null) product.price = newPrice;
      print('Product "$name" updated successfully.\n');
    } else {
      print('Product "$name" not found.\n');
    }
  }

  void deleteProductByName(String name) {
    final product = _findProductByName(name);
    if (product != null) {
      _products.remove(product);
      print('Product "$name" deleted successfully.\n');
    } else {
      print('Product "$name" not found.\n');
    }
  }

  Product? _findProductByName(String name) {
    try {
      return _products.firstWhere(
        (product) => product.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
