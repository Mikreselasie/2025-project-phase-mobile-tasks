// product.dart
class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;
  set name(String name) => _name = name;

  String get description => _description;
  set description(String description) => _description = description;

  double get price => _price;
  set price(double price) => _price = price;

  @override
  String toString() {
    return 'Name: $_name\nDescription: $_description\nPrice: \$$_price';
  }
}
