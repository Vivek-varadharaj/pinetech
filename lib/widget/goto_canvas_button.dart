import 'package:flutter/material.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/screens/cart_canvas_screen.dart';
import 'package:provider/provider.dart';

class GotoCanvasButton extends StatelessWidget {
  const GotoCanvasButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (context, cartProvider, child) =>
            cartProvider.cartProduct.isNotEmpty
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartCanvasScreen(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Go to cart canvas")),
                      ),
                    ),
                  )
                : SizedBox());
  }
}
