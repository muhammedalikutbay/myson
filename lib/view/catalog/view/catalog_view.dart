import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/state/cart_service.dart';
import 'package:myson/core/components/app_search_field.dart';
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
    final cartService = locator<CartService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          CatalogAppBar(title: 'Myson', cartService: cartService),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: AppSearchField(
                    onChanged: viewModel.updateSearchQuery,
                    hintText: 'Search products...',
                  ),
                ),
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
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
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
