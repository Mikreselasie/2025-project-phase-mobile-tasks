import 'product.dart';

class Ecommerce {
  List<Product> products = [];

  // adds a product to products list it accepts product name, description, and price and creates product object
  void addProduct(String name, String description, double price) {
    Product product = Product(
      name: name,
      description: description,
      price: price,
    );

    products.add(product);
    print("Product Added Sucessfully");
  }

  List<Product> viewAll() {
    for (Product product in products) {
      print('Name: ${product.name}');
      print('Description: ${product.description}');
      print('Price: ${product.price}');
    }
    return products;
  }
}
