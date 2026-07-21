import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/currency_entity.dart';

class CurrencyPickerDialog extends StatelessWidget {
  const CurrencyPickerDialog({
    super.key,
    required this.currencies,
    required this.selectedCode,
  });

  final List<CurrencyEntity> currencies;
  final String selectedCode;

  static Future<String?> show(
    BuildContext context, {
    required List<CurrencyEntity> currencies,
    required String selectedCode,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => CurrencyPickerDialog(
        currencies: currencies,
        selectedCode: selectedCode,
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
                    'Select the currency',
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
            ...currencies.map((currency) {
              final isSelected = currency.code == selectedCode;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(currency.code),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${currency.symbol} ( ${currency.name} )',
                          style: textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.neutral500,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: AppColors.primary,
                          size: 18,
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
