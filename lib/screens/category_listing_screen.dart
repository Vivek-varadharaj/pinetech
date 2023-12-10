import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/repositories/api_repository.dart';
import 'package:pinetech/screens/cart_canvas_screen.dart';
import 'package:pinetech/screens/product_list_screen.dart';
import 'package:pinetech/widget/goto_canvas_button.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    ResponseModel response =
        await Provider.of<CategoryProvider>(context, listen: false)
            .getCategories();
    if (!response.isSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Categories",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
        body: SafeArea(
          child: categoryProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          ...categoryProvider.categories
                              .map((category) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: ListTile(
                                      tileColor:
                                          Color.fromARGB(255, 240, 233, 233),
                                      style: ListTileStyle.drawer,
                                      trailing:
                                          Icon(Icons.keyboard_arrow_right),
                                      onTap: () {
                                        categoryProvider
                                            .setSelectedCategory(category);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ProductListScreen(),
                                        ));
                                      },
                                      title: Text(category.name),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                    const GotoCanvasButton()
                  ],
                ),
        ),
      );
    });
  }
}
