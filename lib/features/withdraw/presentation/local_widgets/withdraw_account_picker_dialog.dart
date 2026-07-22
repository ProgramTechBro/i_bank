import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/withdraw_account_entity.dart';

class WithdrawAccountPickerDialog extends StatelessWidget {
  const WithdrawAccountPickerDialog({
    super.key,
    required this.accounts,
    required this.selectedIndex,
  });

  final List<WithdrawAccountEntity> accounts;
  final int? selectedIndex;

  static Future<int?> show(
    BuildContext context, {
    required List<WithdrawAccountEntity> accounts,
    required int? selectedIndex,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => WithdrawAccountPickerDialog(
        accounts: accounts,
        selectedIndex: selectedIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Choose account:', style: textTheme.titleSmall),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(accounts.length, (index) {
              final isSelected = index == selectedIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(index),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          accounts[index].number,
                          style: isSelected
                              ? textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary,
                                )
                              : textTheme.bodyLarge?.copyWith(
                                  color: AppColors.neutral300,
                                ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.primary,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
