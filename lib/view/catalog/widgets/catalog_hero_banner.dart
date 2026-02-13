import 'package:flutter/material.dart';

class CatalogHeroBanner extends StatelessWidget {
  const CatalogHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 180,
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha((0.6 * 255).round()),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomLeft,
                  ),
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spring Event',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Elite Tech. Pure Myson.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
