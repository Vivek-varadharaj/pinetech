
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/providers/product_provider.dart';
import 'package:pinetech/widget/goto_canvas_button.dart';
import 'package:pinetech/widget/product_card.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Select Products",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: SafeArea(child:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        return Consumer<CartProvider>(builder: (context, cartProvider, childe) {
          return productProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: productProvider.products
                              .map((product) => GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (!cartProvider
                                        .addOrRemoveProduct(product)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              duration: Duration(seconds: 2),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                  "Cant add more than 6 products")));
                                    }
                                  },
                                  child: ProductCard(product: product)))
                              .toList(),
                        ),
                      ),
                      const GotoCanvasButton()
                    ],
                  ),
                );
        });
      })),
    );
  }
}
