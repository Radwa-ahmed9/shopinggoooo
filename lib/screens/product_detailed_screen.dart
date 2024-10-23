import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/cart_provider.dart';
import 'package:store_app/models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String id = 'product_details';

  final ProductModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the CartProvider
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.image),
              const SizedBox(height: 10),
              Text(
                product.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${product.price}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),

              Center(
                child: InkWell(
                  onTap: () {
                    cartProvider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  child: Container(
                    height: 56,
                    width: 165,
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     // Add the product to the cart
              //     cartProvider.addToCart(product);
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text('Added to cart')),
              //     );
              //   },
              //   child: const Text('Add to Cart'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
