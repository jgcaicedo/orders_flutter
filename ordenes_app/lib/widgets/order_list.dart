import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        if (provider.ordenes.isEmpty) {
          return const Center(child: Text('No hay órdenes registradas.'));
        }
        return ListView.builder(
          itemCount: provider.ordenes.length,
          itemBuilder: (context, index) {
            final orden = provider.ordenes[index];
            return ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(orden.nombre),
              subtitle: Text('ID: ${orden.id}'),
            );
          },
        );
      },
    );
  }
}
