import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../state/app_state.dart';
import '../utils/format.dart';
import '../widgets/status_badge.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final currentStep = order.status.index;

    return Scaffold(
      appBar: AppBar(title: Text(order.ref)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(order.site, style: Theme.of(context).textTheme.titleLarge),
          Text('Date : ${formatDate(order.date)}'),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusBadge(status: order.status),
          ),
          const SizedBox(height: 24),
          Text('Suivi', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final step in OrderStatus.values)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                step.index <= currentStep
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: step.index <= currentStep
                    ? statusColor(step)
                    : Colors.grey,
              ),
              title: Text(
                step.label,
                style: TextStyle(
                  fontWeight:
                  step.index == currentStep ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          const Divider(height: 32),
          Text('Articles', style: Theme.of(context).textTheme.titleMedium),
          for (final line in order.lines)
            Builder(builder: (context) {
              final product = state.productById(line.productId);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(product.name),
                subtitle: Text('${line.qty} × ${formatFcfa(product.price)}'),
                trailing: Text(formatFcfa(product.price * line.qty)),
              );
            }),
          const Divider(height: 32),
          Text(
            'Total : ${formatFcfa(order.totalWith(state.products))}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}