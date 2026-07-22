import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/withdraw_account_entity.dart';

class WithdrawAccountField extends StatelessWidget {
  const WithdrawAccountField({
    super.key,
    required this.selectedAccount,
    required this.onTap,
  });

  final WithdrawAccountEntity? selectedAccount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral300),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedAccount?.number ?? 'Choose account/card',
                    style: textTheme.labelLarge?.copyWith(
                      color: selectedAccount == null
                          ? AppColors.neutral300
                          : AppColors.neutral900,
                    ),
                  ),
                ),
                const Icon(
                  Icons.unfold_more,
                  size: 20,
                  color: AppColors.neutral500,
                ),
              ],
            ),
          ),
        ),
        if (selectedAccount != null) ...[
          const SizedBox(height: 6),
          Text(
            'Available balance : ${selectedAccount!.balance.toStringAsFixed(0)}\$',
            style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
          ),
        ],
      ],
    );
  }
}
