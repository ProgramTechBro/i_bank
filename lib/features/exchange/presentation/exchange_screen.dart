import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/currency_picker_dialog.dart';
import 'local_widgets/exchange_currency_field.dart';
import 'providers/currencies_provider.dart';
import 'providers/exchange_provider.dart';

class ExchangeScreen extends ConsumerStatefulWidget {
  const ExchangeScreen({super.key});

  @override
  ConsumerState<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends ConsumerState<ExchangeScreen> {
  final _fromController = TextEditingController(text: '1000');
  final _toController = TextEditingController();

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickCurrency({required bool isFrom}) async {
    final currencies = ref.read(currenciesProvider).valueOrNull;
    if (currencies == null) return;

    final exchangeState = ref.read(exchangeNotifierProvider);
    final selected = await CurrencyPickerDialog.show(
      context,
      currencies: currencies,
      selectedCode: isFrom
          ? exchangeState.fromCurrencyCode
          : exchangeState.toCurrencyCode,
    );
    if (selected == null || !mounted) return;

    final notifier = ref.read(exchangeNotifierProvider.notifier);
    if (isFrom) {
      notifier.selectFromCurrency(selected);
    } else {
      notifier.selectToCurrency(selected);
    }
  }

  void _onSwap() => ref.read(exchangeNotifierProvider.notifier).swap();

  void _onExchange() {
    final currencies = ref.read(currenciesProvider).valueOrNull ?? const [];
    ref
        .read(exchangeNotifierProvider.notifier)
        .exchange(_fromController.text, currencies);
  }

  @override
  Widget build(BuildContext context) {
    final currenciesAsync = ref.watch(currenciesProvider);
    final exchangeState = ref.watch(exchangeNotifierProvider);
    final rateLabel = ref.watch(exchangeRateLabelProvider);
    final textTheme = Theme.of(context).textTheme;

    ref.listen(exchangeNotifierProvider.select((s) => s.toAmount), (
      previous,
      next,
    ) {
      _toController.text = next;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Exchange')),
      body: currenciesAsync.when(
        data: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppImages.searchExchangeIllustration,
                  width: 327,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: AppColors.cardShadowPrimary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ExchangeCurrencyField(
                      label: 'From',
                      controller: _fromController,
                      currencyCode: exchangeState.fromCurrencyCode,
                      onTapCurrency: () => _pickCurrency(isFrom: true),
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _onSwap,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: _onSwap,
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: AppColors.semanticError,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExchangeCurrencyField(
                      label: 'To',
                      controller: _toController,
                      currencyCode: exchangeState.toCurrencyCode,
                      readOnly: true,
                      onTapCurrency: () => _pickCurrency(isFrom: false),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Currency rate',
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          rateLabel,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppButton(label: 'Exchange', onPressed: _onExchange),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(currenciesProvider),
        ),
      ),
    );
  }
}
