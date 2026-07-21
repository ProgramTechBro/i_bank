import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/exchange_rate_row.dart';
import 'providers/exchange_rates_provider.dart';

class ExchangeRateScreen extends ConsumerWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratesAsync = ref.watch(exchangeRatesProvider);
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.neutral500,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Exchange rate')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 44),
                Expanded(flex: 2, child: Text('Country', style: headerStyle)),
                Expanded(
                  child: Text(
                    'Buy',
                    textAlign: TextAlign.center,
                    style: headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Sell',
                    textAlign: TextAlign.right,
                    style: headerStyle,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ratesAsync.when(
                data: (rates) => ListView.separated(
                  itemCount: rates.length,
                  separatorBuilder: (_, _) =>
                      const Divider(color: AppColors.neutral200, height: 1),
                  itemBuilder: (context, index) =>
                      ExchangeRateRow(exchangeRate: rates[index]),
                ),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () => ref.invalidate(exchangeRatesProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
