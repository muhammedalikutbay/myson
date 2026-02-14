import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Profile View (Coming Soon)',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }
}
