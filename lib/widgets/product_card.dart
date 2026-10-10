import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/format.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('${product.category} • ${product.unit}'),
        trailing: Text(
          formatFcfa(product.price),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // TODO: open product detail screen
        },
      ),
    );
  }
}