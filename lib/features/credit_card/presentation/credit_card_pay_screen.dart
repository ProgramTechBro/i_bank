import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/credit_card_account_entity.dart';
import 'local_widgets/credit_card_account_picker_dialog.dart';
import 'local_widgets/credit_card_bill_summary_card.dart';
import 'local_widgets/credit_card_dropdown_field.dart';
import 'providers/credit_card_accounts_provider.dart';
import 'providers/credit_card_overview_provider.dart';
import 'providers/credit_card_pay_provider.dart';

class CreditCardPayScreen extends ConsumerStatefulWidget {
  const CreditCardPayScreen({super.key});

  @override
  ConsumerState<CreditCardPayScreen> createState() =>
      _CreditCardPayScreenState();
}

class _CreditCardPayScreenState extends ConsumerState<CreditCardPayScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _pickAccount(
    List<CreditCardAccountEntity> accounts,
    int? selectedIndex,
  ) async {
    final index = await CreditCardAccountPickerDialog.show(
      context,
      accounts: accounts,
      selectedIndex: selectedIndex,
    );
    if (index == null || !mounted) return;
    ref.read(creditCardPayNotifierProvider.notifier).selectAccount(index);
  }

  @override
  Widget build(BuildContext context) {
    final overviewAsync = ref.watch(creditCardOverviewProvider);
    final accountsAsync = ref.watch(creditCardAccountsProvider);
    final payState = ref.watch(creditCardPayNotifierProvider);
    final payNotifier = ref.read(creditCardPayNotifierProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    ref.listen(creditCardPayNotifierProvider.select((s) => s.otp), (
      previous,
      next,
    ) {
      _otpController.text = next;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Credit card')),
      body: overviewAsync.when(
        data: (overview) => accountsAsync.when(
          data: (accounts) {
            final selectedAccount = payState.selectedAccountIndex != null
                ? accounts[payState.selectedAccountIndex!].maskedNumber
                : null;
            final canRequestOtp =
                payState.selectedAccountIndex != null &&
                !payState.isRequestingOtp;
            final canPay = payState.otp.isNotEmpty;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CreditCardBillSummaryCard(
                    transactions: overview.transactions,
                    total: overview.total,
                  ),
                  const SizedBox(height: 24),
                  CreditCardDropdownField(
                    value: selectedAccount,
                    placeholder: 'Choose account/ card',
                    onTap: () =>
                        _pickAccount(accounts, payState.selectedAccountIndex),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get OTP to verify transaction',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _otpController,
                          hintText: 'OTP',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 90,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: canRequestOtp
                              ? payNotifier.requestOtp
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            disabledForegroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Get OTP',
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Pay',
                    isLoading: payState.isSubmitting,
                    onPressed: canPay
                        ? () async {
                            final success = await payNotifier.submit(
                              selectedAccount!,
                            );
                            if (success && context.mounted) {
                              context.go(AppRoutes.creditCardSuccess);
                            }
                          }
                        : null,
                  ),
                ],
              ),
            );
          },
          loading: () => const AppLoader(),
          error: (error, _) => AppErrorView(
            message: 'Something went wrong. Please try again.',
            onRetry: () => ref.invalidate(creditCardAccountsProvider),
          ),
        ),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(creditCardOverviewProvider),
        ),
      ),
    );
  }
}
