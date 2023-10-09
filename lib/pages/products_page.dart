import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:mcbike/repositories/mock_data.dart';
import 'package:mcbike/pages/product_detail_page.dart';
import 'package:mcbike/services/product_service.dart';



class ProductPage extends StatelessWidget {
  late ProductService _productService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Viking Motocross"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          // Scrollable Main Focus Products
          CarouselSlider(
            items: MockData.products
                .map((product) => Image.asset('assets/motocb4.jpg')
                ) // Husk at ændre
                .toList(),
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          
          // List of All Products
          Expanded(
            child: ListView.builder(
              itemCount: MockData.products.length,
              itemBuilder: (context, index) {
                final product = MockData.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
