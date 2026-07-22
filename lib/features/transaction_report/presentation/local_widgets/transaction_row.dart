import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/transaction_category.dart';
import '../../../../core/enums/transaction_direction.dart';
import '../../../../core/enums/transaction_status.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.transaction,
    required this.showDivider,
  });

  final TransactionEntity transaction;
  final bool showDivider;

  IconData get _icon {
    switch (transaction.category) {
      case TransactionCategory.water:
        return Icons.water_drop;
      case TransactionCategory.salary:
        return Icons.account_balance_wallet;
      case TransactionCategory.electricity:
        return Icons.bolt;
      case TransactionCategory.transfer:
        return Icons.swap_horiz;
      case TransactionCategory.internet:
        return Icons.wifi;
    }
  }

  Color get _iconBackgroundColor {
    switch (transaction.category) {
      case TransactionCategory.water:
        return AppColors.primary;
      case TransactionCategory.salary:
        return AppColors.semanticError;
      case TransactionCategory.electricity:
        return AppColors.semanticInfo;
      case TransactionCategory.transfer:
        return AppColors.semanticWarning;
      case TransactionCategory.internet:
        return AppColors.semanticSuccess;
    }
  }

  bool get _isIncrease =>
      transaction.direction == TransactionDirection.increase;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final amountColor = _isIncrease
        ? AppColors.primary
        : AppColors.semanticError;
    final amountSign = _isIncrease ? '+' : '-';

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _iconBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppColors.cardShadowNeutral,
              ),
              child: Icon(_icon, size: 16, color: AppColors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  if (transaction.status != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      transaction.status == TransactionStatus.successful
                          ? 'Successfully'
                          : 'Unsuccessfully',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              '$amountSign \$${transaction.amount.toStringAsFixed(0)}',
              style: textTheme.bodyMedium?.copyWith(color: amountColor),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 16),
          const Divider(color: AppColors.neutral200, height: 1),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
