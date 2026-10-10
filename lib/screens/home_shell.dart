import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'cart_screen.dart';
import 'catalog_screen.dart';
import 'orders_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<AppState>().cartItemCount;

    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [CatalogScreen(), CartScreen(), OrdersScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.store_outlined),
            label: 'Catalogue',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Panier',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Commandes',
          ),
        ],
      ),
    );
  }
}