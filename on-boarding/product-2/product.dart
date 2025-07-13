class Product {
  String _name;
  String _description;
  double _price;
  bool _isCompleted;

  Product({
    required String name,
    required String description,
    required double price,
    required bool isCompleted,
  }) : _name = name,
       _description = description,
       _price = price,
       _isCompleted = isCompleted;

  // Getters to access the private variables
  String get name => _name;
  String get description => _description;
  double get price => _price;
  bool get isCompleted => _isCompleted;

  // Setters to update the private variables
  set name(String name) => _name = name;
  set description(String description) => _description = description;
  set price(double price) => _price = price;
  set isCompleted(bool isCompleted) => _isCompleted = isCompleted;
}
