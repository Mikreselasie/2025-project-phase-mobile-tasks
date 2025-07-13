import 'product.dart';

class ECommerce {
  // Private list to store products
  final List<Product> _products = [];

  // Add a new product
  void addProduct(Product product) {
    if (_products.any((p) => p.name == product.name)) {
      print('Product with the same name already exists.');
      return;
    }
    _products.add(product);
    print('Product added successfully.');
  }

  // View all products
  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.');
      return;
    }
    for (var product in _products) {
      _printProduct(product);
    }
  }

  // View completed products
  void viewCompletedProducts() {
    var completed = _products.where((p) => p.isCompleted).toList();
    if (completed.isEmpty) {
      print('No completed products found.');
    } else {
      for (var product in completed) {
        _printProduct(product);
      }
    }
  }

  // View pending products
  void viewPendingProducts() {
    var pending = _products.where((p) => !p.isCompleted).toList();
    if (pending.isEmpty) {
      print('No pending products found.');
    } else {
      for (var product in pending) {
        _printProduct(product);
      }
    }
  }

  // Edit product by name
  void editProduct(
    String name, {
    String? newName,
    String? newDescription,
    double? newPrice,
    bool? isCompleted,
  }) {
    var product = _products.firstWhere(
      (p) => p.name == name,
      orElse: () => throw Exception('Product not found'),
    );

    if (newName != null) product.name = newName;
    if (newDescription != null) product.description = newDescription;
    if (newPrice != null) product.price = newPrice;
    if (isCompleted != null) product.isCompleted = isCompleted;

    print('Product updated successfully.');
  }

  // Delete product by name
  void deleteProduct(String name) {
    int beforeLength = _products.length;

    _products.removeWhere((p) => p.name == name);

    if (_products.length == beforeLength) {
      print('Product not found.');
    } else {
      print('Product deleted successfully.');
    }
  }

  // Helper method to display a product
  void _printProduct(Product product) {
    print('Name: ${product.name}');
    print('Description: ${product.description}');
    print('Price: \$${product.price}');
    print('Completed: ${product.isCompleted ? "Yes" : "No"}\n');
  }
}
