import 'package:flutter/material.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/theme/app_theme.dart';
import 'package:myson/view/catalog/view/catalog_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
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
      home: const CatalogView(),
    );
  }
}
