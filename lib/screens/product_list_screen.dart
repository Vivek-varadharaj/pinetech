import 'package:flutter/material.dart';
import 'package:pinetech/main.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/providers/product_provider.dart';
import 'package:pinetech/screens/cart_canvas_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProducts(
        Provider.of<CategoryProvider>(context, listen: false)
                .selectedCategory
                ?.name ??
            "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        return Consumer<CartProvider>(builder: (context, cartProvider, childe) {
          return productProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: productProvider.products
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    cartProvider.addOrRemoveProduct(e);
                                  },
                                  child: Card(
                                    color: cartProvider.cartProduct
                                            .where(
                                                (element) => element.id == e.id)
                                            .isNotEmpty
                                        ? Colors.amber
                                        : Colors.white,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          e.imageUrl,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(e.name),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Consumer<CartProvider>(
                        builder: (context, cartProvider, child) => cartProvider
                                .cartProduct.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CartCanvasScreen(),
                                    ));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text("Go to cart canvas")),
                                  ),
                                ),
                              )
                            : SizedBox())
                  ],
                );
        });
      })),
    );
  }
}
