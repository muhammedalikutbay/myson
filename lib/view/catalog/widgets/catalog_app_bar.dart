import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/state/cart_service.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final CartService cartService;

  const CatalogAppBar({
    super.key,
    required this.title,
    required this.cartService,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80.0,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title,
        style: AppTypography.displayLarge.copyWith(fontSize: 28),
      ),
      centerTitle: false,
      actions: [
        ValueListenableBuilder<int>(
          valueListenable: cartService.cartCount,
          builder: (context, count, child) {
            return _CartBadge(count: count);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CartBadge extends StatelessWidget {
  final int count;
  const _CartBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.shopping_bag_outlined, color: Colors.black),
        if (count > 0)
          Positioned(
            right: 0,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
