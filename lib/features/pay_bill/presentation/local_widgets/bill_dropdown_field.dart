import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class BillDropdownField extends StatelessWidget {
  const BillDropdownField({
    super.key,
    required this.value,
    required this.placeholder,
    this.onTap,
  });

  final String? value;
  final String placeholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
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
                value ?? placeholder,
                style: textTheme.labelLarge?.copyWith(
                  color: value == null
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
    );
  }
}
