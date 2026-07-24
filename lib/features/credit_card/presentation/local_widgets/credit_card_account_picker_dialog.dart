import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/credit_card_account_entity.dart';

class CreditCardAccountPickerDialog extends StatelessWidget {
  const CreditCardAccountPickerDialog({
    super.key,
    required this.accounts,
    required this.selectedIndex,
  });

  final List<CreditCardAccountEntity> accounts;
  final int? selectedIndex;

  static Future<int?> show(
    BuildContext context, {
    required List<CreditCardAccountEntity> accounts,
    required int? selectedIndex,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => CreditCardAccountPickerDialog(
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
                  child: Text(
                    'Choose account:',
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
              final isSelected = index == selectedIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(index),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          accounts[index].maskedNumber,
                          textAlign: TextAlign.center,
                          style: isSelected
                              ? textTheme.titleSmall?.copyWith(
                                  color: AppColors.primary,
                                )
                              : textTheme.bodyMedium?.copyWith(
                                  color: AppColors.neutral500,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 18,
                                color: AppColors.primary,
                              )
                            : null,
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
