import 'package:flutter/material.dart';

import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/category_provider.dart';
import 'package:pinetech/providers/product_provider.dart';
import 'package:pinetech/providers/zoom_and_position_provider.dart';
import 'package:pinetech/screens/category_listing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ZoomAndPostionProvider(context)),
      ],
      child: MaterialApp(
        title: 'Image zoom and drag',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CategoryListScreen(),
      ),
    );
  }
}
