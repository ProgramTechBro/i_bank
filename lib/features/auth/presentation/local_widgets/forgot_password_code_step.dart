import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_text_field.dart';

class ForgotPasswordCodeStep extends StatelessWidget {
  const ForgotPasswordCodeStep({
    super.key,
    required this.phone,
    required this.codeController,
    required this.onCodeChanged,
    required this.isSubmitting,
    required this.onChangePassword,
    required this.onResend,
    required this.onChangePhoneNumber,
  });

  final String phone;
  final TextEditingController codeController;
  final ValueChanged<String> onCodeChanged;
  final bool isSubmitting;
  final VoidCallback onChangePassword;
  final VoidCallback onResend;
  final VoidCallback onChangePhoneNumber;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AppTextField(
                controller: codeController,
                label: 'Type a code',
                hintText: 'Code',
                keyboardType: TextInputType.number,
                onChanged: onCodeChanged,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 90,
              height: 44,
              child: ElevatedButton(
                onPressed: onResend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Resend',
                  style: textTheme.labelLarge?.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: textTheme.labelLarge?.copyWith(color: AppColors.neutral700),
            children: [
              const TextSpan(
                text: 'We texted you a code to verify your phone number ',
              ),
              TextSpan(
                text: phone,
                style: textTheme.labelLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "This code will expired 10 minutes after this message. If you don't get a message.",
          style: textTheme.labelLarge?.copyWith(color: AppColors.neutral700),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Change password',
          isLoading: isSubmitting,
          onPressed: onChangePassword,
        ),
        const SizedBox(height: 24),
        Center(
          child: GestureDetector(
            onTap: onChangePhoneNumber,
            child: Text(
              'Change your phone number',
              style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
