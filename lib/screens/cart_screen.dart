import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/cart_provider.dart';
import 'package:store_app/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String id = 'cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.black,
            ),
          )
        ],
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: cart.cartItems.isEmpty
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.cartArrowDown,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem item = cart.cartItems[index];

                      double itemPrice = item.product.price.toDouble();
                      double itemTotalPrice = itemPrice * item.quantity;

                      return ListTile(
                        leading: Image.network(item.product.image),
                        title: Text(item.product.title),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing:
                            Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
                        onLongPress: () => cart.removeFromCart(item.product),
                      );
                    },
                  ),
                ),
                Text(
                  "Long press to remove from the cart",
                  style: TextStyle(fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add functionality for checkout or clearing the cart.
                //     // cart.clearCart();
                //   },
                //   child: Text('Checkout',
                //       style:
                //           TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
                // ),
              ],
            ),
    );
  }
}
