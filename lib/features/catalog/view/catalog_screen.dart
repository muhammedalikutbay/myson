import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/features/catalog/models/product_service.dart';
import 'package:myson/features/catalog/widgets/product_card.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductService.getMockProducts();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Premium Large Title App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background.withAlpha(240),
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              centerTitle: false,
              title: Text(
                'Myson',
                style: AppTypography.displayLarge.copyWith(fontSize: 30),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Hero Section / Category Filter Simulation
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildCategoryChip('All Products', true),
                    _buildCategoryChip('Vacuums', false),
                    _buildCategoryChip('Hair Care', false),
                    _buildCategoryChip('Air Quality', false),
                  ],
                ),
              ),
            ),
          ),

          // Product Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.70,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductCard(
                  product: products[index],
                  onTap: () {
                    debugPrint('Selected: ${products[index].name}');
                  },
                );
              }, childCount: products.length),
            ),
          ),

          // Extra Space at bottom
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppTypography.headline.copyWith(
          fontSize: 14,
          color: isSelected ? Colors.white : AppColors.secondaryLabel,
        ),
      ),
    );
  }
}
