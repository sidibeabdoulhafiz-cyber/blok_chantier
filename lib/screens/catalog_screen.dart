import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? _selectedCategory; // null = all categories

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final categories = state.products.map((p) => p.category).toSet().toList();
    final visibleProducts = _selectedCategory == null
        ? state.products
        : state.products.where((p) => p.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _chip('Tous', _selectedCategory == null, () {
                  setState(() => _selectedCategory = null);
                }),
                for (final category in categories)
                  _chip(category, _selectedCategory == category, () {
                    setState(() => _selectedCategory = category);
                  }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visibleProducts.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: visibleProducts[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}