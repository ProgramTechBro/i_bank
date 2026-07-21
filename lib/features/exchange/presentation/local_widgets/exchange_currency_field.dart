import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class ExchangeCurrencyField extends StatelessWidget {
  const ExchangeCurrencyField({
    super.key,
    required this.label,
    required this.controller,
    required this.currencyCode,
    required this.onTapCurrency,
    this.readOnly = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String currencyCode;
  final VoidCallback onTapCurrency;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  onChanged: onChanged,
                  keyboardType: TextInputType.number,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.neutral900,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapCurrency,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 24,
                      width: 1,
                      color: AppColors.neutral300,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Text(
                      currencyCode,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.unfold_more,
                      size: 16,
                      color: AppColors.neutral500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
