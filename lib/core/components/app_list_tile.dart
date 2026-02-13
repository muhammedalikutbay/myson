import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class AppListTile extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const AppListTile({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
                bottom: BorderSide(color: AppColors.separator, width: 0.5),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyLarge),
          Text(
            value,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }
}
