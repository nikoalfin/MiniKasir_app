import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/product/provider/product_add_provider.dart';
import 'package:mini_kasir/mini_kasir/transaksi/provider/transaksi_provider.dart';
import 'package:mini_kasir/routes/app_routes.dart';
import 'package:provider/provider.dart'; // Impor Provider
import 'package:mini_kasir/mini_kasir/product/provider/product_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductAddProvider()),
        ChangeNotifierProvider(create: (_) => TransaksiProvider()),
        // Tambahkan provider lainnya jika diperlukan
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: myRoute().router,
    );
  }
}
