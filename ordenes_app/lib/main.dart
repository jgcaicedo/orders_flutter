import 'package:flutter/material.dart';

import 'package:ordenes_app/pages/create_order.dart';
import 'package:ordenes_app/pages/orders_page.dart';
import 'package:ordenes_app/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'providers/order_provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'ORDENES APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/ordenes': (context) => const OrdersPage(),
          '/detalle_orden': (context) => const OrderDetailPage(),
        },
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (!auth.loggedIn) {
      return const LoginPage();
    }
    return OrdersPage(
      onLogout: () => auth.logout(),
    );
  }
}

