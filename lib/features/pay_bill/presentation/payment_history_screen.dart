import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/bill_category.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/payment_history_row_card.dart';
import 'local_widgets/payment_history_tabs.dart';
import 'providers/payment_history_provider.dart';
import 'providers/payment_history_tab_provider.dart';

class PaymentHistoryScreen extends ConsumerWidget {
  const PaymentHistoryScreen({super.key, required this.initialCategory});

  final BillCategory initialCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabProvider = paymentHistoryTabProvider(initialCategory);
    final selectedCategory = ref.watch(tabProvider);
    final historyAsync = ref.watch(paymentHistoryProvider(selectedCategory));

    return Scaffold(
      appBar: AppBar(title: const Text('Payment history')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(
          AppRoutes.billCheck,
          extra: selectedCategory,
        ),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaymentHistoryTabs(
              selected: selectedCategory,
              onChanged: (category) =>
                  ref.read(tabProvider.notifier).select(category),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: historyAsync.when(
                data: (history) => ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: history.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final entry = history[index];
                    return PaymentHistoryRowCard(
                      entry: entry,
                      onTap: () => context.push(
                        AppRoutes.billReceipt,
                        extra: {
                          'category': selectedCategory,
                          'entry': entry,
                        },
                      ),
                    );
                  },
                ),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () =>
                      ref.invalidate(paymentHistoryProvider(selectedCategory)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
