import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: (checked) => onChanged(checked ?? false),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: AppColors.neutral300, width: 1.5),
            activeColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral900,
              ),
              children: [
                const TextSpan(text: 'By creating an account your aggree to our '),
                TextSpan(
                  text: 'Term and Condtions',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
