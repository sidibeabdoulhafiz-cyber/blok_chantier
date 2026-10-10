import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/order.dart';
import '../models/product.dart';

class AppState extends ChangeNotifier {
  List<Product> products = [];
  List<Order> orders = [];
  bool isLoading = true;

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
    notifyListeners(); // like Livewire re-render: widgets watching this rebuild
  }
}