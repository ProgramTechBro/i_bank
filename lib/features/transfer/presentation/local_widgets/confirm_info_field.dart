import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class ConfirmInfoField extends StatelessWidget {
  const ConfirmInfoField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 44,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral300),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            value,
            style: textTheme.labelLarge?.copyWith(color: AppColors.neutral900),
          ),
        ),
      ],
    );
  }
}
