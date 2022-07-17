import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_date.dart';
import 'package:shop_app/models/product.dart';

class ProductOverviewPage extends StatelessWidget {
  ProductOverviewPage({Key? key}) : super(key: key);

  final List<Product> loadProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: loadProducts.length,
        itemBuilder: (context, index) {
          return Text(loadProducts[index].title);
        },
      ),
    );
  }
}
