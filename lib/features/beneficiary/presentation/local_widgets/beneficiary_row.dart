import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryRow extends StatelessWidget {
  const BeneficiaryRow({
    super.key,
    required this.beneficiary,
    required this.showDivider,
    required this.onTap,
  });

  final BeneficiaryEntity beneficiary;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryTint,
                backgroundImage: NetworkImage(beneficiary.avatarUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(beneficiary.name, style: textTheme.bodyMedium),
                    Text(
                      beneficiary.number,
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.neutral200, height: 1),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
