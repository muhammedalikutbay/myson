import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class CatalogInfoDialog extends StatelessWidget {
  const CatalogInfoDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CatalogInfoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project Info',
                  style: AppTypography.displayLarge.copyWith(fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Developer', 'M. Ali Kutbay'),
            _buildInfoRow('Project', 'Myson - Premium E-Commerce'),
            _buildInfoRow('Stack', 'Flutter, MVVM, Provider'),
            _buildInfoRow('Design', 'Glassmorphism, Premium UI'),
            const SizedBox(height: 24),
            Text(
              'About the Project',
              style: AppTypography.headline.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Myson is a high-end e-commerce concept application focusing on premium user experience and minimalist design principles.',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(value, style: AppTypography.bodyLarge),
        ],
      ),
    );
  }
}
