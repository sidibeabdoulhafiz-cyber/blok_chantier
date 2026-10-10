import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/order.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  List<Product> products = [];
  List<Order> orders = [];
  bool isLoading = true;

  // Cart: productId -> quantity
  final Map<int, int> _cart = {};

  Future<void> load() async {
    final raw = await rootBundle.loadString('assets/data.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;

    products = (data['products'] as List)
        .map((p) => Product.fromJson(p as Map<String, dynamic>))
        .toList();
    orders = (data['orders'] as List)
        .map((o) => Order.fromJson(o as Map<String, dynamic>))
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Product productById(int id) => products.firstWhere((p) => p.id == id);

  // Construction sites known from existing orders
  List<String> get sites => orders.map((o) => o.site).toSet().toList();

  List<OrderLine> get cartLines => _cart.entries
      .map((e) => OrderLine(productId: e.key, qty: e.value))
      .toList();

  int get cartItemCount => _cart.length;

  int get cartTotal {
    var total = 0;
    _cart.forEach((id, qty) => total += productById(id).price * qty);
    return total;
  }

  void addToCart(Product product, int qty) {
    _cart.update(product.id, (q) => q + qty, ifAbsent: () => qty);
    notifyListeners();
  }

  void changeQty(int productId, int delta) {
    final newQty = (_cart[productId] ?? 0) + delta;
    if (newQty <= 0) {
      _cart.remove(productId);
    } else {
      _cart[productId] = newQty;
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.remove(productId);
    notifyListeners();
  }

  // Turns the cart into an order with status "Reçue" and empties the cart
  Order submitOrder(String site) {
    final lastNumber = orders
        .map((o) => int.parse(o.ref.split('-').last))
        .fold<int>(1000, (max, n) => n > max ? n : max);

    final order = Order(
      ref: 'CMD-${lastNumber + 1}',
      site: site,
      date: DateTime.now(),
      status: OrderStatus.received,
      lines: cartLines,
    );

    orders.insert(0, order);
    _cart.clear();
    notifyListeners();
    return order;
  }
}