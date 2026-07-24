import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/credit_card_transaction_entity.dart';

class CreditCardTransactionRow extends StatelessWidget {
  const CreditCardTransactionRow({
    super.key,
    required this.transaction,
    required this.index,
    required this.showDivider,
  });

  final CreditCardTransactionEntity transaction;
  final int index;
  final bool showDivider;

  static const _iconColors = [
    AppColors.primary,
    AppColors.semanticError,
    AppColors.semanticInfo,
    AppColors.semanticWarning,
  ];

  IconData get _icon => index.isEven ? Icons.camera_alt : Icons.tv;

  Color get _iconColor => _iconColors[index % _iconColors.length];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _iconColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_icon, size: 16, color: AppColors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.title, style: textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd/MM/yyyy').format(transaction.date),
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '- \$${transaction.amount.toStringAsFixed(0)}',
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.semanticError,
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
    );
  }
}
