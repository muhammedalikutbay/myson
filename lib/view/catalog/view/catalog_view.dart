import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/view/catalog/viewmodel/catalog_viewmodel.dart';
import 'package:myson/view/product_detail/view/product_detail_view.dart';
import 'package:myson/view/catalog/widgets/product_card.dart';
import 'package:myson/view/catalog/widgets/catalog_app_bar.dart';
import 'package:myson/view/catalog/widgets/catalog_hero_banner.dart';
import 'package:myson/view/catalog/widgets/category_tabs.dart';
import 'package:myson/data/repositories/i_product_repository.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatalogViewModel(locator<IProductRepository>()),
      child: const _CatalogViewContent(),
    );
  }
}

class _CatalogViewContent extends StatelessWidget {
  const _CatalogViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CatalogViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(title: 'Myson'),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CatalogHeroBanner(),
                CategoryTabs(
                  categories: viewModel.categories,
                  selectedCategory: viewModel.selectedCategory,
                  onCategorySelected: viewModel.updateCategory,
                ),
              ],
            ),
          ),
          _buildProductGrid(viewModel),
          if (viewModel.totalPages > 1)
            SliverToBoxAdapter(child: _buildPagination(viewModel)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildPagination(CatalogViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(viewModel.totalPages, (index) {
          final page = index + 1;
          final isSelected = viewModel.currentPage == page;
          return GestureDetector(
            onTap: () => viewModel.setPage(page),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.black
                    : AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$page',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProductGrid(CatalogViewModel viewModel) {
    if (viewModel.isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (viewModel.products.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('No products found.')),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = viewModel.products[index];
          return ProductCard(
            product: product,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailView(product: product),
              ),
            ),
          );
        }, childCount: viewModel.products.length),
      ),
    );
  }
}
