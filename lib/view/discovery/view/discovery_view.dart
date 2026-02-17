import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/data/models/product.dart';
import 'package:myson/view/discovery/viewmodel/discovery_viewmodel.dart';
import 'package:myson/view/product_detail/view/product_detail_view.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiscoveryViewModel(),
      child: const _DiscoveryViewContent(),
    );
  }
}

class _DiscoveryViewContent extends StatelessWidget {
  const _DiscoveryViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiscoveryViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          if (viewModel.dailyDeal != null)
            SliverToBoxAdapter(
              child: _DailyDealBanner(product: viewModel.dailyDeal!),
            ),
          _buildSectionHeader(context, viewModel),
          _buildDealsGrid(viewModel),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 80.0,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Deals',
        style: AppTypography.displayLarge.copyWith(fontSize: 28),
      ),
      centerTitle: false,
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    DiscoveryViewModel viewModel,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Öne Çıkanlar',
              style: AppTypography.displayLarge.copyWith(fontSize: 22),
            ),
            Text(
              '${viewModel.featuredDeals.length} Ürün',
              style: AppTypography.footnote.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealsGrid(DiscoveryViewModel viewModel) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = viewModel.featuredDeals[index];
          return _DiscoveryProductCard(product: product);
        }, childCount: viewModel.featuredDeals.length),
      ),
    );
  }
}

class _DailyDealBanner extends StatelessWidget {
  final Product product;
  const _DailyDealBanner({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1B232E), // Dark navy from design
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.badgeText ?? 'GÜNÜN TEKLİFİ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailView(product: product),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Şimdi İncele',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(product.imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoveryProductCard extends StatelessWidget {
  final Product product;
  const _DiscoveryProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(product.imageUrl, fit: BoxFit.contain),
                    ),
                  ),
                  if (product.badgeText != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: product.badgeText == 'TÜKENİYOR'
                              ? AppColors.danger
                              : Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.badgeText!,
                          style: TextStyle(
                            color: product.badgeText == 'TÜKENİYOR'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.headline.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${product.price.toStringAsFixed(0)}₺',
                style: AppTypography.headline.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              if (product.isDiscounted) ...[
                const SizedBox(width: 8),
                Text(
                  '${product.originalPrice!.toStringAsFixed(0)}₺',
                  style: AppTypography.footnote.copyWith(
                    color: AppColors.neutralGray,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
