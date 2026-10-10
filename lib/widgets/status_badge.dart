import 'package:flutter/material.dart';

import '../models/order.dart';

Color statusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.received:
      return const Color(0xFF5BC0BE); // teal
    case OrderStatus.relayed:
      return const Color(0xFFEEC844); // yellow
    case OrderStatus.shipped:
      return const Color(0xFFFF4A00); // orange
    case OrderStatus.delivered:
      return Colors.green;
    case OrderStatus.invoiced:
      return const Color(0xFF002060); // navy
  }
}

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}