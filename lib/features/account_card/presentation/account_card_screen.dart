import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_bank_card.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../domain/entities/account_card_report_entity.dart';
import '../domain/entities/user_card_entity.dart';
import 'local_widgets/account_card_tab_selector.dart';
import 'local_widgets/add_new_card_button.dart';
import 'local_widgets/bank_account_row_card.dart';
import 'providers/account_card_report_provider.dart';
import 'providers/account_card_tab_provider.dart';

class AccountCardScreen extends ConsumerWidget {
  const AccountCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(accountCardReportProvider);
    final selectedTab = ref.watch(accountCardTabIndexProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Account and card'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AccountCardTabSelector(
              selectedIndex: selectedTab,
              onChanged: (index) =>
                  ref.read(accountCardTabIndexProvider.notifier).select(index),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: reportAsync.when(
                data: (report) => selectedTab == 0
                    ? _AccountTabContent(report: report)
                    : _CardTabContent(cards: report.cards),
                loading: () => const AppLoader(),
                error: (error, _) => AppErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () => ref.invalidate(accountCardReportProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTabContent extends StatelessWidget {
  const _AccountTabContent({required this.report});

  final AccountCardReportEntity report;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(report.avatarUrl),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            report.userName,
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < report.accounts.length; i++) ...[
            BankAccountRowCard(account: report.accounts[i]),
            if (i != report.accounts.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _CardTabContent extends StatelessWidget {
  const _CardTabContent({required this.cards});

  final List<UserCardEntity> cards;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < cards.length; i++) ...[
                  AppBankCard(
                    cardHolderName: cards[i].holderName,
                    cardNickname: cards[i].nickname,
                    maskedCardNumber: cards[i].maskedNumber,
                    balance: cards[i].balance,
                    style: cards[i].style,
                    showShadowBars: false,
                  ),
                  if (i != cards.length - 1) const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        AddNewCardButton(onTap: () {}),
      ],
    );
  }
}
