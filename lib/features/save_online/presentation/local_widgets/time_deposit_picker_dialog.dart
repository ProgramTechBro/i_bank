import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/time_deposit_option_entity.dart';

class TimeDepositPickerDialog extends StatelessWidget {
  const TimeDepositPickerDialog({
    super.key,
    required this.options,
    required this.selectedIndex,
  });

  final List<TimeDepositOptionEntity> options;
  final int? selectedIndex;

  static Future<int?> show(
    BuildContext context, {
    required List<TimeDepositOptionEntity> options,
    required int? selectedIndex,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => TimeDepositPickerDialog(
        options: options,
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
                    'Choose time deposit',
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
            ...List.generate(options.length, (index) {
              final option = options[index];
              final isSelected = index == selectedIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(index),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${option.months} months '
                      '(Interest rate ${_formatRate(option.interestRate)}%)',
                      style: isSelected
                          ? textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                            )
                          : textTheme.bodyLarge?.copyWith(
                              color: AppColors.neutral900,
                            ),
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

  String _formatRate(double rate) =>
      rate == rate.roundToDouble() ? rate.toStringAsFixed(0) : rate.toString();
}
