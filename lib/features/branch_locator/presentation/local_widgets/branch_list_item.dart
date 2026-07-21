import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/branch_entity.dart';

class BranchListItem extends StatelessWidget {
  const BranchListItem({super.key, required this.branch});

  final BranchEntity branch;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              branch.name,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral900,
              ),
            ),
          ),
          Text(
            branch.distance,
            style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
          ),
        ],
      ),
    );
  }
}
