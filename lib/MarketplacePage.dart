import 'package:flutter/material.dart';
import 'models/Product.dart';


class MarketplacePage extends StatelessWidget {
  final List<Product> products;

  MarketplacePage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: _search)],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            leading: Image.network(product.imageUrl),
            onTap: () => _viewProduct(product),
          );
        },
      ),
    );
  }

  void _search() {
    // Implement search functionality
  }

  void _viewProduct(Product product) {
    // Navigate to a page to view the product details
  }
}
