import 'package:flutter/material.dart';
import 'package:store_app/models/cart_item.dart';
import 'package:store_app/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = []; // Use CartItem instead of ProductModel

  List<CartItem> get cartItems => _cartItems; // Getter for cart items

  void addToCart(ProductModel product) {
    print("Adding product: ${product.title}"); // Debug print

    // Check if the product is already in the cart
    var existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () =>
          CartItem(product: product, quantity: 0), // Provide a default value
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++; // Increment quantity if already in cart
      print("Updated quantity for: ${existingItem.product.title}");
    } else {
      // Add new item to cart if it doesn't exist
      _cartItems.add(CartItem(product: product));
      print("Added new item to cart: ${product.title}");
    }

    notifyListeners(); // Notify listeners about the changes
  }

  void removeFromCart(ProductModel product) {
    _cartItems.removeWhere(
        (item) => item.product.id == product.id); // Remove item by product id
    notifyListeners(); // Notify listeners about the changes
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // Notify listeners about the changes
  }

  double get totalPrice {
    return _cartItems.fold(
        0,
        (total, item) =>
            total + item.totalPrice); // Calculate total price of cart
  }
}
