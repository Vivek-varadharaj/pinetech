import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/providers/product_provider.dart';
import 'package:pinetech/screens/category_listing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Image Container Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CategoryListScreen(),
      ),
    );
  }
}


