import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/transaction_type.dart';
import '../domain/entities/transfer_entity.dart';
import 'local_widgets/account_selector_field.dart';
import 'local_widgets/account_picker_dialog.dart';
import 'local_widgets/beneficiary_card.dart';
import 'local_widgets/transaction_type_card.dart';
import 'local_widgets/transfer_details_form.dart';
import 'providers/accounts_provider.dart';
import 'providers/beneficiaries_provider.dart';
import 'providers/transfer_amount_provider.dart';
import 'providers/transfer_form_provider.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _amountController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickAccount() async {
    final accounts = ref.read(accountsProvider).valueOrNull;
    if (accounts == null) return;
    final index = await AccountPickerDialog.show(context, accounts: accounts);
    if (index == null || !mounted) return;
    ref.read(transferFormNotifierProvider.notifier).selectAccount(index);
  }

  void _onAmountChanged(String value) {
    ref.read(transferAmountTextProvider.notifier).update(value);
  }

  void _onSubmit() {
    final formState = ref.read(transferFormNotifierProvider);
    final accounts = ref.read(accountsProvider).valueOrNull;
    final selectedAccount = formState.selectedAccountIndex != null
        ? (accounts?[formState.selectedAccountIndex!])
        : null;

    final transfer = TransferEntity(
      name: _nameController.text,
      cardNumber: _cardNumberController.text,
      amount: double.tryParse(_amountController.text) ?? 0,
      content: _contentController.text,
      transactionType: formState.transactionType,
    );

    context.push(
      AppRoutes.transferConfirm,
      extra: {
        'transfer': transfer,
        'fromMasked': selectedAccount == null
            ? ''
            : '${selectedAccount.cardBrand} ${selectedAccount.maskedNumber}',
        'toName': _nameController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsProvider);
    final beneficiariesAsync = ref.watch(beneficiariesProvider);
    final formState = ref.watch(transferFormNotifierProvider);
    final amountInWords = ref.watch(transferAmountInWordsProvider);
    final textTheme = Theme.of(context).textTheme;
    final captionStyle = textTheme.labelSmall?.copyWith(
      color: AppColors.neutral500,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            accountsAsync.when(
              data: (accounts) => AccountSelectorField(
                selectedAccount: formState.selectedAccountIndex != null
                    ? accounts[formState.selectedAccountIndex!]
                    : null,
                onTap: _pickAccount,
              ),
              loading: () => const AppLoader(),
              error: (error, _) => AppErrorView(
                message: 'Something went wrong. Please try again.',
                onRetry: () => ref.invalidate(accountsProvider),
              ),
            ),
            const SizedBox(height: 24),
            Text('Choose transaction', style: captionStyle),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TransactionTypeCard(
                    icon: Icons.credit_card,
                    label: 'Transfer via\ncard number',
                    isSelected:
                        formState.transactionType == TransactionType.cardNumber,
                    onTap: () => ref
                        .read(transferFormNotifierProvider.notifier)
                        .selectTransactionType(TransactionType.cardNumber),
                  ),
                  const SizedBox(width: 16),
                  TransactionTypeCard(
                    icon: Icons.person_outline,
                    label: 'Transfer to\nthe same bank',
                    isSelected:
                        formState.transactionType == TransactionType.sameBank,
                    onTap: () => ref
                        .read(transferFormNotifierProvider.notifier)
                        .selectTransactionType(TransactionType.sameBank),
                  ),
                  const SizedBox(width: 16),
                  TransactionTypeCard(
                    icon: Icons.account_balance_outlined,
                    label: 'Transfer to\nanother bank',
                    isSelected:
                        formState.transactionType == TransactionType.otherBank,
                    onTap: () => ref
                        .read(transferFormNotifierProvider.notifier)
                        .selectTransactionType(TransactionType.otherBank),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('Choose beneficiary', style: captionStyle),
                const Spacer(),
                Text(
                  'Find beneficiary',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: beneficiariesAsync.when(
                data: (beneficiaries) => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: beneficiaries.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) return const AddBeneficiaryCard();
                    final beneficiary = beneficiaries[index - 1];
                    return BeneficiaryCard(
                      beneficiary: beneficiary,
                      isSelected:
                          formState.selectedBeneficiaryIndex == index - 1,
                      onTap: () {
                        ref
                            .read(transferFormNotifierProvider.notifier)
                            .selectBeneficiary(index - 1);
                        _nameController.text = beneficiary.name;
                      },
                    );
                  },
                ),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () => ref.invalidate(beneficiariesProvider),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TransferDetailsForm(
              nameController: _nameController,
              cardNumberController: _cardNumberController,
              amountController: _amountController,
              contentController: _contentController,
              amountInWords: amountInWords,
              onAmountChanged: _onAmountChanged,
              saveToDirectory: formState.saveToDirectory,
              onToggleSaveToDirectory: (_) => ref
                  .read(transferFormNotifierProvider.notifier)
                  .toggleSaveToDirectory(),
              onSubmit: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
