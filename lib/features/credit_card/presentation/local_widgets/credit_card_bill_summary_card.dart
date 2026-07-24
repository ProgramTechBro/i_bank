import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/credit_card_transaction_entity.dart';
import 'credit_card_transaction_row.dart';

class CreditCardBillSummaryCard extends StatelessWidget {
  const CreditCardBillSummaryCard({
    super.key,
    required this.transactions,
    required this.total,
  });

  final List<CreditCardTransactionEntity> transactions;
  final double total;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColors.cardShadowPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < transactions.length; i++)
            CreditCardTransactionRow(
              transaction: transactions[i],
              index: i,
              showDivider: true,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL', style: textTheme.titleSmall),
              Text(
                '-\$${total.toStringAsFixed(0)}',
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.semanticError,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
