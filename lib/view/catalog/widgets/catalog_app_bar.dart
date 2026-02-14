import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/view/catalog/widgets/catalog_info_dialog.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onInfoPressed;

  const CatalogAppBar({super.key, required this.title, this.onInfoPressed});

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
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.black),
          onPressed:
              onInfoPressed ??
              () {
                CatalogInfoDialog.show(context);
              },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
