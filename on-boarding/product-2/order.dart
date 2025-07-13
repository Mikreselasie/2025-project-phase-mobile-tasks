import 'product.dart';

class Order {
  Product _product;
  int _orderCount;
  bool _isCompleted;

  Order({
    required Product product,
    required int orderCount,
    required bool isCompleted,
  }) : _product = product,
       _isCompleted = isCompleted,
       _orderCount = orderCount;

  Product get product => _product;
  int get orderCount => _orderCount;
  bool get isCompleted => _isCompleted;
}
