import 'package:flutter/material.dart';
import 'package:mcbike/pages/products_page.dart';

class LandingPage extends StatelessWidget {
  // Define the dark grey color
  final Color almostBlackGrey = const Color.fromRGBO(30, 30, 30, 1.0);

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/landing_image.png', height: 200, width: 200),  // Adjust the size as needed
            const SizedBox(height: 30),
            const Text('Welcome to Viking Motocross', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Discover the best motocross equipment!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
              },
        
              style: ElevatedButton.styleFrom(backgroundColor: almostBlackGrey, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }
}
