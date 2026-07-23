import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/transaction_status.dart';
import '../../domain/entities/payment_history_entry_entity.dart';

class PaymentHistoryRowCard extends StatelessWidget {
  const PaymentHistoryRowCard({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final PaymentHistoryEntryEntity entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isSuccessful = entry.status == TransactionStatus.successful;
    final labelStyle = textTheme.bodySmall?.copyWith(
      color: AppColors.neutral500,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Text(entry.month, style: textTheme.titleSmall),
                Text(
                  DateFormat('dd/MM/yyyy').format(entry.date),
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Status', style: labelStyle),
                const SizedBox(width: 8),
                Text(
                  isSuccessful ? 'Successfully' : 'Unsuccessfully',
                  style: textTheme.labelSmall?.copyWith(
                    color: isSuccessful
                        ? AppColors.primary
                        : AppColors.semanticError,
                  ),
                ),
                const Spacer(),
                Text('Amount', style: labelStyle),
                const SizedBox(width: 8),
                Text(
                  '\$${entry.amount.toStringAsFixed(0)}',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            if (entry.company != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('Company', style: labelStyle),
                  const SizedBox(width: 8),
                  Text(
                    entry.company!,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
