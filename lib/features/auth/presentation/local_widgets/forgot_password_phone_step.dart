import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_text_field.dart';

class ForgotPasswordPhoneStep extends StatelessWidget {
  const ForgotPasswordPhoneStep({
    super.key,
    required this.phoneController,
    required this.onPhoneChanged,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController phoneController;
  final ValueChanged<String> onPhoneChanged;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          controller: phoneController,
          label: 'Type your phone number',
          hintText: '(+84)',
          keyboardType: TextInputType.phone,
          onChanged: onPhoneChanged,
        ),
        const SizedBox(height: 16),
        Text(
          'We texted you a code to verify your phone number',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 16),
        AppButton(label: 'Send', isLoading: isSending, onPressed: onSend),
      ],
    );
  }
}
