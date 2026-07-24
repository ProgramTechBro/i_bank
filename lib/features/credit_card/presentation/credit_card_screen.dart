import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared_widgets/app_bank_card.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/credit_card_bill_summary_card.dart';
import 'providers/credit_card_overview_provider.dart';

class CreditCardScreen extends ConsumerWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(creditCardOverviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Credit card')),
      body: overviewAsync.when(
        data: (overview) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBankCard(
                cardHolderName: overview.card.holderName,
                cardNickname: overview.card.nickname,
                maskedCardNumber: overview.card.maskedNumber,
                balance: overview.card.balance,
                style: overview.card.style,
              ),
              const SizedBox(height: 24),
              CreditCardBillSummaryCard(
                transactions: overview.transactions,
                total: overview.total,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Pay',
                onPressed: () => context.push(AppRoutes.creditCardPay),
              ),
            ],
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
