import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.title,
    this.value,
    this.valueStyle,
    this.onTap,
  });

  final String title;
  final String? value;
  final TextStyle? valueStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final showChevron = onTap != null;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.neutral200),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, style: textTheme.bodyMedium)),
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.neutral300,
              )
            else if (value != null)
              Text(
                value!,
                style:
                    valueStyle ??
                    textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
