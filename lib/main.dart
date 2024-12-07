import 'package:arch/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A9F4);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router.config(),
    );
  }
}
