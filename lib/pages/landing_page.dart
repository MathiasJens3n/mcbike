import 'package:flutter/material.dart';
import 'package:mcbike/pages/products_page.dart';
import 'package:mcbike/app_colors.dart';

class LandingPage extends StatelessWidget {
  // Define the dark grey color
  final Color almostBlackGrey = Color.fromRGBO(30, 30, 30, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/landing_image.png', height: 200, width: 200),  // Adjust the size as needed
            SizedBox(height: 30),
            Text('Welcome to Viking Motocross', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Discover the best motocross equipment!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Shop Now'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
              },
        
              style: ElevatedButton.styleFrom(primary: almostBlackGrey, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
