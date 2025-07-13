class Product {
  String _name;
  String _description;
  double _price;

  Product({
    required String name,
    required String description,
    required double price,
  }) : _name = name,
       _description = description,
       _price = price;

  // Getters to access the private variables
  String get name => _name;
  String get description => _description;
  double get price => _price;

  // Setters to update the private variables
  set name(String name) => _name = name;
  set description(String description) => _description = description;
  set price(double price) => _price = price;
}
