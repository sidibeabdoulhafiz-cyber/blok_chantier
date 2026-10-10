import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../utils/format.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _site;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final lines = state.cartLines;

    if (lines.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Panier')),
        body: const Center(child: Text('Votre panier est vide')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Panier')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                final line = lines[index];
                final product = state.productById(line.productId);
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                    '${formatFcfa(product.price)} / ${product.unit}\n'
                        'Total : ${formatFcfa(product.price * line.qty)}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => state.changeQty(product.id, -1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${line.qty}'),
                      IconButton(
                        onPressed: () => state.changeQty(product.id, 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      IconButton(
                        onPressed: () => state.removeFromCart(product.id),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Choisir le chantier'),
                  value: _site,
                  items: [
                    for (final site in state.sites)
                      DropdownMenuItem(value: site, child: Text(site)),
                  ],
                  onChanged: (value) => setState(() => _site = value),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total : ${formatFcfa(state.cartTotal)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _site == null
                        ? null
                        : () {
                      final order = state.submitOrder(_site!);
                      setState(() => _site = null);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Commande ${order.ref} envoyée'),
                        ),
                      );
                    },
                    child: const Text('Envoyer la commande'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}