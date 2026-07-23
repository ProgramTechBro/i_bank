import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/managed_save_entity.dart';

class ManagedSaveRowCard extends StatelessWidget {
  const ManagedSaveRowCard({super.key, required this.save});

  final ManagedSaveEntity save;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.bodySmall?.copyWith(
      color: AppColors.neutral500,
    );
    final valueStyle = textTheme.labelSmall?.copyWith(
      color: AppColors.primary,
    );
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColors.cardShadowPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Account', style: textTheme.titleSmall),
              Text(save.accountNumber, style: textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('From', style: labelStyle),
              Text(dateFormat.format(save.fromDate), style: valueStyle),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('To', style: labelStyle),
              Text(dateFormat.format(save.toDate), style: valueStyle),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Time deposit', style: labelStyle),
              Text('${save.depositMonths} months', style: valueStyle),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Interest rate', style: labelStyle),
              Text(
                '${save.interestRate.toStringAsFixed(0)}%',
                style: valueStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
