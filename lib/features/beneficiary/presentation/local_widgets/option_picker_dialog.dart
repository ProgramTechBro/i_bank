import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class OptionPickerDialog extends StatelessWidget {
  const OptionPickerDialog({
    super.key,
    required this.title,
    required this.options,
  });

  final String title;
  final List<String> options;

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required List<String> options,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => OptionPickerDialog(title: title, options: options),
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
                Expanded(child: Text(title, style: textTheme.titleSmall)),
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
            ...options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(option),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      option,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
