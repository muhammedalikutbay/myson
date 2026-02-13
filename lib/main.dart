import 'package:flutter/material.dart';
import 'package:myson/core/theme/app_theme.dart';
import 'package:myson/features/catalog/models/product_service.dart';

void main() {
  runApp(const MysonApp());
}

class MysonApp extends StatelessWidget {
  const MysonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myson',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ThemeTestScreen(),
    );
  }
}

class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductService.getMockProducts();
    for (var product in products) {
      debugPrint('Product Loaded: ${product.name} - \$${product.price}');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Myson Design System')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Large Title',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Headline Typography',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'This is a body text example following minimalist design principles with high-end metrics.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Premium Style Card (Inset Grouped)'),
                    const SizedBox(height: 10),
                    Text(
                      'Data Check: ${products.length} Products Loaded',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Action Button'),
            ),
          ],
        ),
      ),
    );
  }
}
