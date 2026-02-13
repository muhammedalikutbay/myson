import 'package:flutter/material.dart';
import 'package:myson/core/theme/app_theme.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Myson Design System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Large Title', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 10),
            Text('Headline Typography', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(
              'This is a body text example following minimalist design principles with high-end metrics.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Premium Style Card (Inset Grouped)'),
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
