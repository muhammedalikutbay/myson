import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/state/cart_service.dart';

class CatalogAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final CartService cartService;
  final ValueChanged<String> onSearchChanged;

  const CatalogAppBar({
    super.key,
    required this.title,
    required this.cartService,
    required this.onSearchChanged,
  });

  @override
  State<CatalogAppBar> createState() => _CatalogAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CatalogAppBarState extends State<CatalogAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80.0,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: _isSearching
          ? _buildSearchField()
          : Text(
              widget.title,
              style: AppTypography.displayLarge.copyWith(fontSize: 28),
            ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                widget.onSearchChanged('');
              }
            });
          },
        ),
        ValueListenableBuilder<int>(
          valueListenable: widget.cartService.cartCount,
          builder: (context, count, child) {
            return _CartBadge(count: count);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: widget.onSearchChanged,
        style: AppTypography.bodyLarge.copyWith(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: AppColors.neutralGray,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  const _CartBadge({required this.count});
  // ... rest of _CartBadge implementation remains the same (I'll re-add it below for completeness in replacement)
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
