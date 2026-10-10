import 'product.dart';

enum OrderStatus {
  received('Reçue'),
  relayed('Transmise'),
  shipped('En livraison'),
  delivered('Livrée'),
  invoiced('Facturée');

  final String label;
  const OrderStatus(this.label);

  // "Shipped" (JSON) -> OrderStatus.shipped
  static OrderStatus fromApi(String value) {
    return OrderStatus.values.firstWhere(
          (s) => s.name.toLowerCase() == value.toLowerCase(),
    );
  }
}

class OrderLine {
  final int productId;
  final int qty;

  const OrderLine({required this.productId, required this.qty});

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    return OrderLine(
      productId: json['productId'] as int,
      qty: json['qty'] as int,
    );
  }
}

class Order {
  final String ref;
  final String site;
  final DateTime date;
  final OrderStatus status;
  final List<OrderLine> lines;

  const Order({
    required this.ref,
    required this.site,
    required this.date,
    required this.status,
    required this.lines,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ref: json['ref'] as String,
      site: json['site'] as String,
      date: DateTime.parse(json['date'] as String),
      status: OrderStatus.fromApi(json['status'] as String),
      lines: (json['lines'] as List)
          .map((l) => OrderLine.fromJson(l as Map<String, dynamic>))
          .toList(),
    );
  }

  int totalWith(List<Product> products) {
    var total = 0;
    for (final line in lines) {
      final product = products.firstWhere((p) => p.id == line.productId);
      total += product.price * line.qty;
    }
    return total;
  }
}