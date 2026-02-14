import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Search View (Coming Soon)',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }
}
