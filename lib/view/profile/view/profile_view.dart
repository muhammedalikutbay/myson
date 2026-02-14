import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/components/app_toast.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(
              'Profile',
              style: AppTypography.displayLarge.copyWith(fontSize: 28),
            ),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Profile Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.secondaryBackground,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.neutralGray,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guest User',
                            style: AppTypography.headline.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'guest@myson.com',
                            style: AppTypography.footnote,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Settings List
                  _ProfileMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  const Divider(height: 32, color: AppColors.separator),
                  _ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Log out',
                    textColor: AppColors.danger,
                    onTap: () => AppToast.show(context, 'Under Development'),
                  ),
                  const SizedBox(height: 120), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor ?? AppColors.label),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          color: textColor ?? AppColors.label,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.neutralGray),
      onTap: onTap,
    );
  }
}
