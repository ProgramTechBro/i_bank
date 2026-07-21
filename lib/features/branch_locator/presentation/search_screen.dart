import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../core/providers/bottom_nav_provider.dart';
import '../../../core/shared_widgets/app_bottom_nav_bar.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/search_option_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNavIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SearchOptionCard(
            title: 'Branch',
            subtitle: 'Search for branch',
            illustrationAsset: AppIcons.searchBranchIllustration,
            onTap: () => context.push(AppRoutes.branch),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Interest rate',
            subtitle: 'Search for interest rate',
            illustrationAsset: AppIcons.searchInterestRateIllustration,
            onTap: () => context.push(AppRoutes.interestRate),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Exchange rate',
            subtitle: 'Search for exchange rate',
            illustrationAsset: AppIcons.searchExchangeRateIllustration,
            onTap: () => context.push(AppRoutes.exchangeRate),
          ),
          const SizedBox(height: 20),
          SearchOptionCard(
            title: 'Exchange',
            subtitle: 'Exchange amount of money',
            illustrationAsset: AppIcons.searchExchangeIllustration,
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: selectedNavIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).select(index);
          AppRoutes.goToTab(context, index);
        },
      ),
    );
  }
}
