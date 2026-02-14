import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Discovery View (Coming Soon)',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }
}
