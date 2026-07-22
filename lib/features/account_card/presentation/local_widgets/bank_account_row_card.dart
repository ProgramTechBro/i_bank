import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/bank_account_entity.dart';

class BankAccountRowCard extends StatelessWidget {
  const BankAccountRowCard({super.key, required this.account});

  final BankAccountEntity account;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedBalance = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
    ).format(account.balance);

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
              Text(account.label, style: textTheme.titleSmall),
              Text(account.number, style: textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available balance',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
              Text(
                formattedBalance,
                style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Branch',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
              Text(
                account.branch,
                style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
