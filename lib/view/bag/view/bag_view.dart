import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Bag View (Coming Soon)',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }
}
