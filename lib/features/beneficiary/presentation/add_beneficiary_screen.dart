import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/transaction_type.dart';
import '../../../core/extensions/transaction_type_extension.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import 'local_widgets/beneficiary_dropdown_field.dart';
import 'local_widgets/beneficiary_type_card.dart';
import 'local_widgets/option_picker_dialog.dart';
import 'providers/add_beneficiary_form_provider.dart';

class AddBeneficiaryScreen extends ConsumerStatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  ConsumerState<AddBeneficiaryScreen> createState() =>
      _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends ConsumerState<AddBeneficiaryScreen> {
  static const _banks = [
    'Citibank',
    'HSBC',
    'Chase',
    'Wells Fargo',
    'Bank of America',
  ];
  static const _branches = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Miami',
  ];

  final _transactionNameController = TextEditingController();
  final _cardNumberController = TextEditingController();

  @override
  void dispose() {
    _transactionNameController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickBank() async {
    final selected = await OptionPickerDialog.show(
      context,
      title: 'Choose bank',
      options: _banks,
    );
    if (selected == null || !mounted) return;
    ref.read(addBeneficiaryFormNotifierProvider.notifier).selectBank(selected);
  }

  Future<void> _pickBranch() async {
    final selected = await OptionPickerDialog.show(
      context,
      title: 'Choose branch',
      options: _branches,
    );
    if (selected == null || !mounted) return;
    ref
        .read(addBeneficiaryFormNotifierProvider.notifier)
        .selectBranch(selected);
  }

  Future<void> _onSave() async {
    final success = await ref
        .read(addBeneficiaryFormNotifierProvider.notifier)
        .submit(
          transactionName: _transactionNameController.text,
          cardNumber: _cardNumberController.text,
        );
    if (success && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(addBeneficiaryFormNotifierProvider);
    final notifier = ref.read(addBeneficiaryFormNotifierProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final isOtherBank = formState.transferType == TransactionType.otherBank;

    return Scaffold(
      appBar: AppBar(title: const Text('Add new')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.neutral200,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryTint,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: AppColors.primaryDisabled,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Push Puttichai',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                for (final type in TransactionType.values) ...[
                  if (type != TransactionType.values.first)
                    const SizedBox(width: 12),
                  Expanded(
                    child: BeneficiaryTypeCard(
                      icon: type.icon,
                      label: type.shortLabel,
                      isSelected: formState.transferType == type,
                      onTap: () => notifier.selectTransferType(type),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: AppColors.cardShadowPrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isOtherBank) ...[
                    BeneficiaryDropdownField(
                      value: formState.bank,
                      placeholder: 'Choose bank',
                      onTap: _pickBank,
                    ),
                    const SizedBox(height: 16),
                    BeneficiaryDropdownField(
                      value: formState.branch,
                      placeholder: 'Choose branch',
                      onTap: _pickBranch,
                    ),
                    const SizedBox(height: 16),
                  ],
                  AppTextField(
                    controller: _transactionNameController,
                    hintText: 'Transaction name',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _cardNumberController,
                    hintText: 'Card number',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _transactionNameController,
                      _cardNumberController,
                    ]),
                    builder: (context, _) {
                      final canSave =
                          _transactionNameController.text.isNotEmpty &&
                          _cardNumberController.text.isNotEmpty &&
                          (!isOtherBank ||
                              (formState.bank != null &&
                                  formState.branch != null));
                      return AppButton(
                        label: 'Save to directory',
                        isLoading: formState.isSubmitting,
                        onPressed: canSave ? _onSave : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
