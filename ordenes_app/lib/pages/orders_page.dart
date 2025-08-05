import 'package:flutter/material.dart';
import 'package:ordenes_app/widgets/order_list.dart';


class OrdersPage extends StatelessWidget {
  final VoidCallback? onLogout;
  const OrdersPage({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: const OrderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/detalle_orden');
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}