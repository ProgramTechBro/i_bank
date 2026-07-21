import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_text_field.dart';

class TransferDetailsForm extends StatelessWidget {
  const TransferDetailsForm({
    super.key,
    required this.nameController,
    required this.cardNumberController,
    required this.amountController,
    required this.contentController,
    required this.amountInWords,
    required this.onAmountChanged,
    required this.saveToDirectory,
    required this.onToggleSaveToDirectory,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController cardNumberController;
  final TextEditingController amountController;
  final TextEditingController contentController;
  final String amountInWords;
  final ValueChanged<String> onAmountChanged;
  final bool saveToDirectory;
  final ValueChanged<bool> onToggleSaveToDirectory;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColors.cardShadowPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(controller: nameController, hintText: 'Name'),
          const SizedBox(height: 16),
          AppTextField(
            controller: cardNumberController,
            hintText: 'Card number',
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: amountController,
            hintText: 'Amount',
            keyboardType: TextInputType.number,
            onChanged: onAmountChanged,
          ),
          const SizedBox(height: 16),
          AppTextField(controller: contentController, hintText: 'Content'),
          if (amountInWords.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              amountInWords,
              style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: saveToDirectory,
                  onChanged: (value) => onToggleSaveToDirectory(value ?? false),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(
                    color: AppColors.neutral300,
                    width: 1.5,
                  ),
                  activeColor: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Save to directory of beneficiary',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(label: 'Confirm', onPressed: onSubmit),
        ],
      ),
    );
  }
}
