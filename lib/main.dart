import 'package:flutter/material.dart';
import 'package:mcbike/pages/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:mcbike/app_colors.dart';

import 'provider/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // Provide the CartProvider
      child: McBikeApp(),
    ),
  );
}

class McBikeApp extends StatelessWidget {
  // Define the dark grey color
  final Color almostBlackGrey = Color.fromRGBO(30, 30, 30, 1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viking Motocross',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: almostBlackGrey),
        ),
      ),
      home: LandingPage(),
    );
  }
}