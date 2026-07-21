import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class TransactionTypeCard extends StatelessWidget {
  const TransactionTypeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.neutral200,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.white, size: 24),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
