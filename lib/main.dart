import 'package:flutter/material.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/theme/app_theme.dart';
import 'package:myson/view/main/view/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myson',
      theme: AppTheme.lightTheme,
      home: const MainView(),
    );
  }
}
