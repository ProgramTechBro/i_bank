import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/search_option_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SearchOptionCard(
            title: 'Branch',
            subtitle: 'Search for branch',
            illustrationAsset: AppImages.searchBranchIllustration,
            onTap: () => context.push(AppRoutes.branch),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Interest rate',
            subtitle: 'Search for interest rate',
            illustrationAsset: AppImages.searchInterestRateIllustration,
            onTap: () => context.push(AppRoutes.interestRate),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Exchange rate',
            subtitle: 'Search for exchange rate',
            illustrationAsset: AppImages.searchExchangeRateIllustration,
            onTap: () => context.push(AppRoutes.exchangeRate),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Exchange',
            subtitle: 'Exchange amount of money',
            illustrationAsset: AppImages.searchExchangeIllustration,
            onTap: () => context.push(AppRoutes.exchange),
          ),
        ],
      ),
    );
  }
}
