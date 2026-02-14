import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/state/cart_service.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/components/app_toast.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = locator<CartService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ValueListenableBuilder<List<CartItem>>(
        valueListenable: cartService.items,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return const _EmptyBag();
          }

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const _BagAppBar(),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = items[index];
                        return _BagItemCard(
                          item: item,
                          cartService: cartService,
                        );
                      }, childCount: items.length),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _BagSummary(totalPrice: cartService.totalPrice),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 150)),
                ],
              ),
              Positioned(
                bottom: 100,
                left: 20,
                right: 20,
                child: _CheckoutButton(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BagAppBar extends StatelessWidget {
  const _BagAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Bag',
        style: AppTypography.displayLarge.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
    );
  }
}

class _BagItemCard extends StatelessWidget {
  final CartItem item;
  final CartService cartService;

  const _BagItemCard({required this.item, required this.cartService});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image - Circle background like in image
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
            child: Image.network(item.product.imageUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        style: AppTypography.headline.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '\$${item.product.price}',
                      style: AppTypography.headline.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Myson Technology', // Consistent with user request
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.neutralGray,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => cartService.removeFromCart(item.product.id),
                      child: Text(
                        'Remove',
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _QuantityIcon(
                            icon: Icons.remove,
                            onTap: () =>
                                cartService.updateQuantity(item.product.id, -1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              '${item.quantity}',
                              style: AppTypography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _QuantityIcon(
                            icon: Icons.add,
                            onTap: () =>
                                cartService.updateQuantity(item.product.id, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.black, size: 18),
    );
  }
}

class _BagSummary extends StatelessWidget {
  final double totalPrice;

  const _BagSummary({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        children: [
          const Divider(height: 48, color: AppColors.separator),
          _SummaryRow(
            label: 'Subtotal',
            value: '\$${totalPrice.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _SummaryRow(
            label: 'Shipping',
            value: 'FREE',
            valueColor: AppColors.primaryBlue,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTypography.displayLarge.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: AppTypography.displayLarge.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
        Text(
          value,
          style: AppTypography.bodyLarge.copyWith(
            color: valueColor ?? Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => AppToast.show(context, 'Under Development'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Check Out',
            style: AppTypography.headline.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

class _EmptyBag extends StatelessWidget {
  const _EmptyBag();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: AppColors.neutralGray.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Your bag is empty',
              style: AppTypography.displayLarge.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'Add some Myson technology to your bag to get started.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
