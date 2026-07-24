import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/providers/bottom_nav_provider.dart';
import '../../../core/shared_widgets/app_bottom_nav_bar.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import '../../home/presentation/providers/home_dashboard_provider.dart';
import 'local_widgets/setting_row.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const double _avatarPeekHeight = 92;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(homeDashboardProvider);
    final selectedNavIndex = ref.watch(bottomNavIndexProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Setting'),
      ),
      body: dashboardAsync.when(
        data: (dashboard) => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: _avatarPeekHeight),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SettingRow(
                            title: 'Password',
                            onTap: () => context.push(AppRoutes.changePassword),
                          ),
                          SettingRow(title: 'Touch ID', onTap: () {}),
                          SettingRow(
                            title: 'Languages',
                            onTap: () => context.push(AppRoutes.language),
                          ),
                          SettingRow(
                            title: 'App information',
                            onTap: () =>
                                context.push(AppRoutes.appInformation),
                          ),
                          const SettingRow(
                            title: 'Customer care',
                            value: '19008989',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(dashboard.avatarUrl),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dashboard.userName,
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(homeDashboardProvider),
        ),
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
