import 'eCommerce.dart';
import 'product.dart';
import 'dart:io';

// Assuming Product and ECommerce classes are defined above

void main() {
  final app = ECommerce();
  bool running = true;

  while (running) {
    print('\n=== eCommerce Menu ===');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Completed Products');
    print('4. View Pending Products');
    print('5. Edit Product');
    print('6. Delete Product');
    print('7. Exit');
    stdout.write('Choose an option (1-7): ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter product description: ');
        String description = stdin.readLineSync()!;
        stdout.write('Enter product price: ');
        double price = double.parse(stdin.readLineSync()!);
        stdout.write('Is the product completed? (y/n): ');
        bool isCompleted = stdin.readLineSync()!.toLowerCase() == 'y';

        app.addProduct(
          Product(
            name: name,
            description: description,
            price: price,
            isCompleted: isCompleted,
          ),
        );
        break;

      case '2':
        app.viewAllProducts();
        break;

      case '3':
        app.viewCompletedProducts();
        break;

      case '4':
        app.viewPendingProducts();
        break;

      case '5':
        stdout.write('Enter the name of the product to edit: ');
        String oldName = stdin.readLineSync()!;
        stdout.write('New name (leave empty to skip): ');
        String? newName = stdin.readLineSync();
        stdout.write('New description (leave empty to skip): ');
        String? newDescription = stdin.readLineSync();
        stdout.write('New price (leave empty to skip): ');
        String? newPriceInput = stdin.readLineSync();
        stdout.write('Is completed? (y/n or leave empty to skip): ');
        String? isCompletedInput = stdin.readLineSync();

        try {
          app.editProduct(
            oldName,
            newName: newName!.isEmpty ? null : newName,
            newDescription: newDescription!.isEmpty ? null : newDescription,
            newPrice: newPriceInput!.isEmpty
                ? null
                : double.parse(newPriceInput),
            isCompleted: isCompletedInput!.isEmpty
                ? null
                : isCompletedInput.toLowerCase() == 'y',
          );
        } catch (e) {
          print('Error: ${e.toString()}');
        }
        break;

      case '6':
        stdout.write('Enter the name of the product to delete: ');
        String nameToDelete = stdin.readLineSync()!;
        app.deleteProduct(nameToDelete);
        break;

      case '7':
        running = false;
        print('Goodbye!');
        break;

      default:
        print('Invalid choice. Try again.');
    }
  }
}
