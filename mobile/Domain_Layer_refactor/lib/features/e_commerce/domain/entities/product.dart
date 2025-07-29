class Product {
  double _id;
  String _name;
  String _description;
  String _imageURL;
  double _price;

  Product({
    required String name,
    required String description,
    required double price,
    required String imageURL,
    required double id,
  }) : _name = name,
       _description = description,
       _price = price,
       _imageURL = imageURL,
       _id = id;
}
