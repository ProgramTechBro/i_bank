import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/withdraw_account_field.dart';
import 'local_widgets/withdraw_account_picker_dialog.dart';
import 'local_widgets/withdraw_amount_grid.dart';
import 'providers/withdraw_accounts_provider.dart';
import 'providers/withdraw_form_provider.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final _phoneController = TextEditingController();
  final _customAmountController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _customAmountController.dispose();
    super.dispose();
  }

  Future<void> _pickAccount() async {
    final accounts = ref.read(withdrawAccountsProvider).valueOrNull;
    if (accounts == null) return;
    final formState = ref.read(withdrawFormNotifierProvider);
    final index = await WithdrawAccountPickerDialog.show(
      context,
      accounts: accounts,
      selectedIndex: formState.selectedAccountIndex,
    );
    if (index == null || !mounted) return;
    ref.read(withdrawFormNotifierProvider.notifier).selectAccount(index);
  }

  Future<void> _onVerify() async {
    final accounts = ref.read(withdrawAccountsProvider).valueOrNull;
    final formState = ref.read(withdrawFormNotifierProvider);
    if (accounts == null || formState.selectedAccountIndex == null) return;

    final amount =
        formState.selectedAmount ??
        double.tryParse(_customAmountController.text) ??
        0;

    final success = await ref
        .read(withdrawFormNotifierProvider.notifier)
        .submit(
          accountNumber: accounts[formState.selectedAccountIndex!].number,
          phoneNumber: _phoneController.text,
          amount: amount,
        );

    if (success && mounted) context.go(AppRoutes.withdrawSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(withdrawAccountsProvider);
    final formState = ref.watch(withdrawFormNotifierProvider);
    final notifier = ref.read(withdrawFormNotifierProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SvgPicture.asset(
                AppImages.transferSuccessIllustration,
                width: 342,
              ),
            ),
            const SizedBox(height: 24),
            accountsAsync.when(
              data: (accounts) => WithdrawAccountField(
                selectedAccount: formState.selectedAccountIndex != null
                    ? accounts[formState.selectedAccountIndex!]
                    : null,
                onTap: _pickAccount,
              ),
              loading: () => const AppLoader(),
              error: (error, _) => AppErrorView(
                message: 'Something went wrong. Please try again.',
                onRetry: () => ref.invalidate(withdrawAccountsProvider),
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _phoneController,
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Text(
              'Choose amount',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.neutral500,
              ),
            ),
            const SizedBox(height: 8),
            formState.isOtherSelected
                ? AppTextField(
                    controller: _customAmountController,
                    hintText: 'Amount',
                    keyboardType: TextInputType.number,
                  )
                : WithdrawAmountGrid(
                    selectedAmount: formState.selectedAmount,
                    isOtherSelected: formState.isOtherSelected,
                    onSelectAmount: notifier.selectAmount,
                    onSelectOther: notifier.selectOther,
                  ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: Listenable.merge([
                _phoneController,
                _customAmountController,
              ]),
              builder: (context, _) {
                final amountValid = formState.isOtherSelected
                    ? _customAmountController.text.isNotEmpty
                    : formState.selectedAmount != null;
                final canVerify =
                    formState.selectedAccountIndex != null &&
                    _phoneController.text.isNotEmpty &&
                    amountValid;
                return AppButton(
                  label: 'Verify',
                  isLoading: formState.isSubmitting,
                  onPressed: canVerify ? _onVerify : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
