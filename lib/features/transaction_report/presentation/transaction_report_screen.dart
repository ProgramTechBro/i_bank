import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/extensions/datetime_extension.dart';
import '../../../core/shared_widgets/app_bank_card.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../domain/entities/transaction_entity.dart';
import '../domain/entities/transaction_report_entity.dart';
import 'local_widgets/transaction_balance_chart.dart';
import 'local_widgets/transaction_row.dart';
import 'providers/transaction_report_provider.dart';

class TransactionReportScreen extends ConsumerWidget {
  const TransactionReportScreen({super.key});

  static const double _cardPeekHeight = 56;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(transactionReportProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Transaction report'),
      ),
      body: reportAsync.when(
        data: (report) => _TransactionReportContent(report: report),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(transactionReportProvider),
        ),
      ),
    );
  }
}

class _TransactionReportContent extends StatelessWidget {
  const _TransactionReportContent({required this.report});

  final TransactionReportEntity report;

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<TransactionEntity>>{};
    for (final transaction in report.transactions) {
      grouped.putIfAbsent(transaction.date.dayLabel, () => []).add(transaction);
    }
    final groupEntries = grouped.entries.toList();

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: TransactionReportScreen._cardPeekHeight),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 189, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TransactionBalanceChart(
                        balance: report.chartBalance,
                        history: report.balanceHistory,
                        highlightedIndex: report.balanceHistory.length > 3
                            ? 3
                            : null,
                      ),
                      const SizedBox(height: 24),
                      for (var g = 0; g < groupEntries.length; g++) ...[
                        Text(
                          groupEntries[g].key,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.neutral500),
                        ),
                        const SizedBox(height: 8),
                        for (var i = 0; i < groupEntries[g].value.length; i++)
                          TransactionRow(
                            transaction: groupEntries[g].value[i],
                            showDivider:
                                !(g == groupEntries.length - 1 &&
                                    i == groupEntries[g].value.length - 1),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 24,
          right: 24,
          child: AppBankCard(
            cardHolderName: report.cardHolderName,
            cardNickname: report.cardNickname,
            maskedCardNumber: report.maskedCardNumber,
            balance: report.balance,
          ),
        ),
      ],
    );
  }
}
