import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Bag',
                style: AppTypography.displayLarge.copyWith(fontSize: 28),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: AppColors.neutralGray,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Your bag is empty', style: AppTypography.headline),
                  const SizedBox(height: 12),
                  Text(
                    'Looks like you haven\'t added any items to your bag yet.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to home/catalog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Start Shopping'),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Bottom padding for navigation bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
