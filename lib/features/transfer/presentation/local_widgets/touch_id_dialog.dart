import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class TouchIdDialog extends StatelessWidget {
  const TouchIdDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.fingerprint, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              'Touch ID for CoBank',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Access to the application',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: AppColors.neutral500),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: textTheme.labelLarge?.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
