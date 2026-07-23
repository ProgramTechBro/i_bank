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
import 'local_widgets/save_online_dropdown_field.dart';
import 'local_widgets/time_deposit_picker_dialog.dart';
import 'providers/save_online_cards_provider.dart';
import 'providers/save_online_form_provider.dart';
import 'providers/time_deposit_options_provider.dart';

class SaveOnlineAddScreen extends ConsumerStatefulWidget {
  const SaveOnlineAddScreen({super.key});

  @override
  ConsumerState<SaveOnlineAddScreen> createState() =>
      _SaveOnlineAddScreenState();
}

class _SaveOnlineAddScreenState extends ConsumerState<SaveOnlineAddScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickCard() async {
    final index = await context.push<int>(AppRoutes.saveOnlineChooseCard);
    if (index == null || !mounted) return;
    ref.read(saveOnlineFormNotifierProvider.notifier).selectCard(index);
  }

  Future<void> _pickDeposit() async {
    final options = ref.read(timeDepositOptionsProvider).valueOrNull;
    if (options == null) return;
    final formState = ref.read(saveOnlineFormNotifierProvider);
    final index = await TimeDepositPickerDialog.show(
      context,
      options: options,
      selectedIndex: formState.selectedDepositIndex,
    );
    if (index == null || !mounted) return;
    ref.read(saveOnlineFormNotifierProvider.notifier).selectDeposit(index);
  }

  Future<void> _onVerify() async {
    final cards = ref.read(saveOnlineCardsProvider).valueOrNull ?? [];
    final options = ref.read(timeDepositOptionsProvider).valueOrNull ?? [];
    final formState = ref.read(saveOnlineFormNotifierProvider);
    if (formState.selectedCardIndex == null ||
        formState.selectedDepositIndex == null) {
      return;
    }
    final deposit = options[formState.selectedDepositIndex!];

    final success = await ref
        .read(saveOnlineFormNotifierProvider.notifier)
        .submit(
          accountLabel: cards[formState.selectedCardIndex!].maskedNumber,
          depositMonths: deposit.months,
          interestRate: deposit.interestRate,
          amount: double.tryParse(_amountController.text) ?? 0,
        );

    if (success && mounted) context.go(AppRoutes.saveOnlineSuccess);
  }

  String _formatRate(double rate) =>
      rate == rate.roundToDouble() ? rate.toStringAsFixed(0) : rate.toString();

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(saveOnlineCardsProvider);
    final optionsAsync = ref.watch(timeDepositOptionsProvider);
    final formState = ref.watch(saveOnlineFormNotifierProvider);
    final textTheme = Theme.of(context).textTheme;

    final selectedCard =
        cardsAsync.valueOrNull != null && formState.selectedCardIndex != null
        ? cardsAsync.valueOrNull![formState.selectedCardIndex!]
        : null;
    final selectedDeposit =
        optionsAsync.valueOrNull != null &&
            formState.selectedDepositIndex != null
        ? optionsAsync.valueOrNull![formState.selectedDepositIndex!]
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Add')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SvgPicture.asset(
                AppImages.saveOnlineIllustration,
                width: 324,
              ),
            ),
            const SizedBox(height: 24),
            cardsAsync.when(
              data: (_) => SaveOnlineDropdownField(
                value: selectedCard == null
                    ? null
                    : '${selectedCard.nickname} ${selectedCard.maskedNumber}',
                placeholder: 'Choose account/ card',
                onTap: _pickCard,
              ),
              loading: () => const AppLoader(),
              error: (error, _) => AppErrorView(
                message: 'Something went wrong. Please try again.',
                onRetry: () => ref.invalidate(saveOnlineCardsProvider),
              ),
            ),
            if (selectedCard != null) ...[
              const SizedBox(height: 6),
              Text(
                'Available balance : ${selectedCard.balance.toStringAsFixed(0)}\$',
                style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
              ),
            ],
            const SizedBox(height: 16),
            SaveOnlineDropdownField(
              value: selectedDeposit == null
                  ? null
                  : '${selectedDeposit.months} months',
              placeholder: 'Choose time deposit',
              onTap: _pickDeposit,
            ),
            if (selectedDeposit != null) ...[
              const SizedBox(height: 6),
              Text(
                'Interest rate ${_formatRate(selectedDeposit.interestRate)}%/ '
                '${selectedDeposit.months} months',
                style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
              ),
            ],
            const SizedBox(height: 16),
            AppTextField(
              controller: _amountController,
              hintText: 'Amount (At least \$1000)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _amountController,
              builder: (context, _) {
                final amount = double.tryParse(_amountController.text) ?? 0;
                final canVerify =
                    selectedCard != null &&
                    selectedDeposit != null &&
                    amount >= 1000;
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
