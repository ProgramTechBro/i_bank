import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_beneficiary_card.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/prepaid_recharge_entity.dart';
import 'local_widgets/prepaid_account_field.dart';
import 'local_widgets/prepaid_amount_chip.dart';
import 'providers/prepaid_accounts_provider.dart';
import 'providers/prepaid_beneficiaries_provider.dart';
import 'providers/prepaid_form_provider.dart';

class MobilePrepaidScreen extends ConsumerStatefulWidget {
  const MobilePrepaidScreen({super.key});

  @override
  ConsumerState<MobilePrepaidScreen> createState() =>
      _MobilePrepaidScreenState();
}

class _MobilePrepaidScreenState extends ConsumerState<MobilePrepaidScreen> {
  final _phoneController = TextEditingController();

  static const List<double> _presetAmounts = [10, 20, 30];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    final formState = ref.read(prepaidFormNotifierProvider);
    final accounts = ref.read(prepaidAccountsProvider).valueOrNull ?? [];
    final beneficiaries =
        ref.read(prepaidBeneficiariesProvider).valueOrNull ?? [];
    final selectedAccount = formState.selectedAccountIndex != null
        ? accounts[formState.selectedAccountIndex!]
        : null;
    final selectedBeneficiary = formState.selectedBeneficiaryIndex != null
        ? beneficiaries[formState.selectedBeneficiaryIndex!]
        : null;

    final recharge = PrepaidRechargeEntity(
      beneficiaryName: selectedBeneficiary?.name ?? '',
      phoneNumber: _phoneController.text,
      amount: formState.selectedAmount ?? 0,
    );

    context.push(
      AppRoutes.mobilePrepaidConfirm,
      extra: {
        'recharge': recharge,
        'fromMasked': selectedAccount == null
            ? ''
            : '${selectedAccount.cardBrand} ${selectedAccount.maskedNumber}',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(prepaidAccountsProvider);
    final beneficiariesAsync = ref.watch(prepaidBeneficiariesProvider);
    final formState = ref.watch(prepaidFormNotifierProvider);
    final notifier = ref.read(prepaidFormNotifierProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final captionStyle = textTheme.labelSmall?.copyWith(
      color: AppColors.neutral500,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mobile prepaid')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            accountsAsync.when(
              data: (accounts) => PrepaidAccountField(
                selectedAccount: formState.selectedAccountIndex != null
                    ? accounts[formState.selectedAccountIndex!]
                    : null,
                onTap: () {
                  if (accounts.isEmpty) return;
                  notifier.selectAccount(0);
                },
              ),
              loading: () => const AppLoader(),
              error: (error, _) => AppErrorView(
                message: 'Something went wrong. Please try again.',
                onRetry: () => ref.invalidate(prepaidAccountsProvider),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('Directory', style: captionStyle),
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
                    if (index == 0) return const AppAddBeneficiaryCard();
                    final beneficiary = beneficiaries[index - 1];
                    return AppBeneficiaryCard(
                      name: beneficiary.name,
                      avatarUrl: beneficiary.avatarUrl,
                      isSelected:
                          formState.selectedBeneficiaryIndex == index - 1,
                      onTap: () {
                        notifier.selectBeneficiary(index - 1);
                        _phoneController.text = beneficiary.phoneNumber;
                      },
                    );
                  },
                ),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () => ref.invalidate(prepaidBeneficiariesProvider),
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _phoneController,
              label: 'Phone number',
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Text('Choose amount', style: captionStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 0; i < _presetAmounts.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  Expanded(
                    child: PrepaidAmountChip(
                      label: '\$${_presetAmounts[i].toStringAsFixed(0)}',
                      isSelected: formState.selectedAmount == _presetAmounts[i],
                      onTap: () => notifier.selectAmount(_presetAmounts[i]),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            AppButton(label: 'Confirm', onPressed: _onConfirm),
          ],
        ),
      ),
    );
  }
}
