import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/features/catalog/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Premium Header with Hero Image
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.secondaryBackground,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product_image_${product.id}',
                child: Container(
                  color: AppColors.background,
                  padding: const EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: 20,
                  ),
                  child: Image.network(product.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          // Product Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: AppTypography.footnote.copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: AppTypography.displayLarge.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTypography.displayLarge.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Overview', style: AppTypography.headline),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: AppTypography.bodyLarge.copyWith(
                      height: 1.5,
                      color: AppColors.secondaryLabel,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Specifications Section Simulation
                  _buildSpecRow('Weight', 'Varies by model'),
                  _buildSpecRow('Suction Power', 'Intelligent suction'),
                  _buildSpecRow('Filtration', 'Whole-machine filtration'),

                  const SizedBox(height: 120), // Padding for sticky button
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Action Bar
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.8),
          border: const Border(
            top: BorderSide(color: AppColors.separator, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add to Bag'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.separator, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyLarge),
          Text(
            value,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }
}
