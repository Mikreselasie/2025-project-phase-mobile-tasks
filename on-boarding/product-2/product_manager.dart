import 'product.dart';

class ProductManager {
  final List<Product> _products = [];

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
