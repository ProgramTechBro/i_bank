import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/interest_rate_row.dart';
import 'providers/interest_rates_provider.dart';

class InterestRateScreen extends ConsumerWidget {
  const InterestRateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratesAsync = ref.watch(interestRatesProvider);
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.neutral500,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Interest rate')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Interest kind', style: headerStyle),
                ),
                Expanded(
                  child: Text(
                    'Deposit',
                    textAlign: TextAlign.center,
                    style: headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Rate',
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
                      InterestRateRow(interestRate: rates[index]),
                ),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () => ref.invalidate(interestRatesProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
