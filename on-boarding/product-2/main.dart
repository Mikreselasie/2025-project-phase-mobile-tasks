// main.dart
import 'dart:io';
import 'product.dart';
import 'product_manager.dart';

void main() {
  final productManager = ProductManager();

  while (true) {
    print('\n📦 Welcome to eCommerce CLI App');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Single Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Choose an option: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter description: ');
        String desc = stdin.readLineSync()!;
        stdout.write('Enter price: ');
        double price = double.tryParse(stdin.readLineSync()!) ?? 0.0;

        productManager.addProduct(Product(name, desc, price));
        break;

      case '2':
        productManager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter product index (starting from 1): ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;
        productManager.viewProduct(index - 1);
        break;

      case '4':
        stdout.write('Enter product index to edit (starting from 1): ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;

        stdout.write('New name (or press enter to skip): ');
        String? name = stdin.readLineSync();
        name = name!.isEmpty ? null : name;

        stdout.write('New description (or press enter to skip): ');
        String? desc = stdin.readLineSync();
        desc = desc!.isEmpty ? null : desc;

        stdout.write('New price (or press enter to skip): ');
        String? priceInput = stdin.readLineSync();
        double? price = priceInput!.isEmpty
            ? null
            : double.tryParse(priceInput);

        productManager.editProduct(
          index - 1,
          name: name,
          description: desc,
          price: price,
        );
        break;

      case '5':
        stdout.write('Enter product index to delete (starting from 1): ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;
        productManager.deleteProduct(index - 1);
        break;

      case '6':
        print('👋 Exiting... Goodbye!');
        return;

      default:
        print('❌ Invalid option. Please try again.\n');
    }
  }
}
