// product_manager.dart
import 'product.dart';

class ProductManager {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print('✅ Product added successfully.\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('⚠️ No products available.\n');
      return;
    }
    for (int i = 0; i < _products.length; i++) {
      print('🔢 Product ${i + 1}:\n${_products[i]}\n');
    }
  }

  void viewProduct(int index) {
    if (_isValidIndex(index)) {
      print(_products[index]);
    } else {
      print('❌ Product not found.\n');
    }
  }

  void editProduct(
    int index, {
    String? name,
    String? description,
    double? price,
  }) {
    if (_isValidIndex(index)) {
      if (name != null) _products[index].name = name;
      if (description != null) _products[index].description = description;
      if (price != null) _products[index].price = price;
      print('✏️ Product updated successfully.\n');
    } else {
      print('❌ Product not found.\n');
    }
  }

  void deleteProduct(int index) {
    if (_isValidIndex(index)) {
      _products.removeAt(index);
      print('🗑️ Product deleted successfully.\n');
    } else {
      print('❌ Product not found.\n');
    }
  }

  bool _isValidIndex(int index) => index >= 0 && index < _products.length;
}
