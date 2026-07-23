import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppBeneficiaryCard extends StatelessWidget {
  const AppBeneficiaryCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String avatarUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
            Text(
              name,
              style: textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppAddBeneficiaryCard extends StatelessWidget {
  const AppAddBeneficiaryCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowPrimary,
        ),
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: AppColors.primary, size: 24),
          ),
        ),
      ),
    );
  }
}
