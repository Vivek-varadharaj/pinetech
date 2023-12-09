import 'package:flutter/material.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ...categoryProvider.categories
                        .map((category) => ListTile(
                              onTap: () {
                                categoryProvider.setSelectedCategory(category);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductListScreen(),
                                ));
                              },
                              title: Text(category.name),
                            ))
                        .toList()
                  ],
                ),
              ),
              Consumer<CartProvider>(
                  builder: (context, cartProvider, child) =>
                      cartProvider.cartProduct.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text("Go to cart canvas")),
                              ),
                            )
                          : SizedBox())
            ],
          ),
        ),
      );
    });
  }
}
