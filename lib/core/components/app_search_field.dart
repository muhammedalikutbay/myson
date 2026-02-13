import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class AppSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controller;

  const AppSearchField({
    super.key,
    required this.onChanged,
    this.hintText = 'Search...',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: AppColors.neutralGray,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.neutralGray),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
