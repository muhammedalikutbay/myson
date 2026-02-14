import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/state/cart_service.dart';
import 'package:myson/data/models/product.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/components/app_button.dart';
import 'package:myson/core/components/app_toast.dart';
import 'package:myson/core/components/app_list_tile.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartService = locator<CartService>();

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
                  AppListTile(label: 'Weight', value: 'Varies by model'),
                  AppListTile(
                    label: 'Suction Power',
                    value: 'Intelligent suction',
                  ),
                  AppListTile(
                    label: 'Filtration',
                    value: 'Whole-machine filtration',
                    showDivider: false,
                  ),

                  const SizedBox(height: 40),

                  // Add to Bag Button (Now part of the scrollable list)
                  AppButton(
                    label: 'Add to Bag',
                    backgroundColor: AppColors.primaryBlue,
                    onPressed: () {
                      cartService.addToCart(product);
                      AppToast.show(context, 'Added to Bag');
                    },
                  ),

                  const SizedBox(
                    height: 100,
                  ), // Bottom padding to prevent overlap with glassmorphic bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
