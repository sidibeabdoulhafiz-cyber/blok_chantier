import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../utils/format.dart';
import '../widgets/status_badge.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mes commandes')),
        body: const Center(child: Text('Aucune commande')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mes commandes')),
      body: ListView.builder(
        itemCount: state.orders.length,
        itemBuilder: (context, index) {
          final order = state.orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(order.ref),
              subtitle: Text(
                '${order.site}\n${formatDate(order.date)} • '
                    '${formatFcfa(order.totalWith(state.products))}',
              ),
              isThreeLine: true,
              trailing: StatusBadge(status: order.status),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailScreen(order: order),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}