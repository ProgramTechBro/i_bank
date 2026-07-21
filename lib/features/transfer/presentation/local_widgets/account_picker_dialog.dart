import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/account_entity.dart';

class AccountPickerDialog extends StatelessWidget {
  const AccountPickerDialog({super.key, required this.accounts});

  final List<AccountEntity> accounts;

  static Future<int?> show(
    BuildContext context, {
    required List<AccountEntity> accounts,
  }) {
    return showDialog<int>(
      context: context,
      builder: (context) => AccountPickerDialog(accounts: accounts),
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
                  child: Text(
                    'Choose account / card',
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall,
                  ),
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
              final account = accounts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(index),
                  child: Text(
                    '${account.cardBrand} ${account.maskedNumber}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral900,
                    ),
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
