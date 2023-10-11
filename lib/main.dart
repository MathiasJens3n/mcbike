import 'package:flutter/material.dart';
import 'package:mcbike/pages/landing_page.dart';
import 'package:mcbike/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        // Add more providers as needed
      ],
      child: const McBikeApp(),
    ),
  );
}

class McBikeApp extends StatelessWidget {
  // Define the dark grey color
  final Color almostBlackGrey = const Color.fromRGBO(30, 30, 30, 1.0);

  const McBikeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viking Motocross',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ),
      home: const LandingPage(),
    );
  }
}
