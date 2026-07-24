import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_bank_card.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../domain/entities/home_dashboard_entity.dart';
import 'local_widgets/home_header.dart';
import 'local_widgets/home_quick_actions_grid.dart';
import 'providers/home_dashboard_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(homeDashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: dashboardAsync.when(
        data: (dashboard) => _HomeContent(dashboard: dashboard),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(homeDashboardProvider),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.dashboard});

  final HomeDashboardEntity dashboard;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: HomeHeader(
              userName: dashboard.userName,
              avatarUrl: dashboard.avatarUrl,
              notificationCount: 3,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBankCard(
                      cardHolderName: dashboard.cardHolderName,
                      cardNickname: dashboard.cardNickname,
                      maskedCardNumber: dashboard.maskedCardNumber,
                      balance: dashboard.balance,
                    ),
                    const SizedBox(height: 24),
                    const HomeQuickActionsGrid(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
