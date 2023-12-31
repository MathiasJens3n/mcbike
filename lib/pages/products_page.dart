import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mcbike/provider/product_provider.dart';
import 'package:mcbike/pages/product_detail_page.dart';
import 'package:mcbike/services/product_api_service.dart';
import 'package:mcbike/widgets/drawer.dart';
import 'package:mcbike/widgets/shoppingcart_appbar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productService =
      ProductApiService(baseUrl: "https://192.168.56.1:5000/api/product");

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    try {
      final products = await productService.fetchAllProducts();
      productProvider.addProducts(products);
    } catch (error) {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      appBar: const ShoppingCartAppBar(),
      drawer: const AppMenu(),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                  labelText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value) async {
                  productProvider.productList.clear();
                  productProvider.addProducts(
                      await productService.fetchProductsByCategory(value));
                }),
          ),

          // Scrollable Main Focus Products
          CarouselSlider(
            items: [
              Image.asset('assets/motocb4.jpg'),
              Image.asset('assets/motocb2.png'),
              Image.asset('assets/landing_image.png'),
            ],
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),

          // List of All Products
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.productList.length,
              itemBuilder: (context, index) {
                final product = productProvider.productList[index];
                return ListTile(
                  leading: Image.asset("assets/motocb2.png"),
                  //Image.memory(base64Decode(product.images.last.base64)),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
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
