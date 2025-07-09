import 'package:pos/model/product_models.dart';

class CartItem {
  final Recipe product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
