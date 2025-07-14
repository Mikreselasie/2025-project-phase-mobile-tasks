import 'dart:io';
import 'product.dart';
import 'product_manager.dart';

void main() {
  final productManager = ProductManager();

  while (true) {
    print('##########################\nWelcome to eCommerce CLI App');
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
        stdout.write('Enter product name to view: ');
        String name = stdin.readLineSync()!;
        productManager.viewProductByName(name);
        break;

      case '4':
        stdout.write('Enter the product name to edit: ');
        String name = stdin.readLineSync()!;

        stdout.write('New name (press enter to skip): ');
        String? newName = stdin.readLineSync();
        if (newName != null && newName.trim().isEmpty) newName = null;

        stdout.write('New description (press enter to skip): ');
        String? newDesc = stdin.readLineSync();
        if (newDesc != null && newDesc.trim().isEmpty) newDesc = null;

        stdout.write('New price (press enter to skip): ');
        String? priceInput = stdin.readLineSync();
        double? newPrice = (priceInput != null && priceInput.trim().isNotEmpty)
            ? double.tryParse(priceInput)
            : null;

        productManager.editProductByName(
          name,
          newName: newName,
          newDescription: newDesc,
          newPrice: newPrice,
        );
        break;

      case '5':
        stdout.write('Enter the product name to delete: ');
        String name = stdin.readLineSync()!;
        productManager.deleteProductByName(name);
        break;

      case '6':
        print('👋 Exiting... Goodbye!');
        return;

      default:
        print('❌ Invalid option. Try again.\n');
    }
  }
}
