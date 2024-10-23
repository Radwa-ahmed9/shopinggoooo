import 'package:store_app/models/cart_item.dart';
import 'package:store_app/models/product_model.dart';

class Cart {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(ProductModel product) {
    var existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      _items.add(CartItem(product: product));
    } else {
      existingItem.quantity++;
    }
  }

  void removeItem(ProductModel product) {
    _items.removeWhere((item) => item.product.id == product.id);
  }

  double get totalPrice =>
      _items.fold(0, (total, item) => total + item.totalPrice);

  void clear() {
    _items.clear();
  }
}
