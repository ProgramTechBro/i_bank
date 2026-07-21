import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryCard extends StatelessWidget {
  const BeneficiaryCard({
    super.key,
    required this.beneficiary,
    required this.isSelected,
    required this.onTap,
  });

  final BeneficiaryEntity beneficiary;
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(beneficiary.avatarUrl),
            ),
            Text(
              beneficiary.name,
              style: textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBeneficiaryCard extends StatelessWidget {
  const AddBeneficiaryCard({super.key, this.onTap});

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
