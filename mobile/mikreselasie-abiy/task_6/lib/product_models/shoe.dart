import 'package:task_6/helpers/shoe_sizes.dart';
import 'package:task_6/product.dart';

class Shoe extends Product {
  ShoeSize _shoeSize;
  Shoe({
    required super.name,
    required super.description,
    required super.price,
    required super.rating,
    required super.imageURL,
    required ShoeSize shoeSize,
    required super.productCategory,
  }) : _shoeSize = shoeSize;

  ShoeSize get shoeSize => _shoeSize;
  set shoeSize(ShoeSize shoeSize) => _shoeSize = shoeSize;
}
