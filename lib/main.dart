import 'package:flutter/material.dart';
import 'package:myson/core/theme/app_theme.dart';
import 'package:myson/features/catalog/view/catalog_screen.dart';

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
      home: const CatalogScreen(),
    );
  }
}
