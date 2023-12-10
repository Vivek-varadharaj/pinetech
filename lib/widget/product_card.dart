import 'package:flutter/material.dart';
import 'package:pinetech/models/product.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Provider.of<CartProvider>(context, listen: false)
              .cartProduct
              .where((element) => element.id == product.id)
              .isNotEmpty
          ? Colors.amber.withOpacity(0.5)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
