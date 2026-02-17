import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onInfoPressed;

  const CatalogAppBar({super.key, required this.title, this.onInfoPressed});

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/muhammedalikutbay/myson');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
          onPressed: onInfoPressed ?? _launchGitHub,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
