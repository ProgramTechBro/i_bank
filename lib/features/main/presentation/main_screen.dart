import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/bottom_nav_provider.dart';
import '../../../core/shared_widgets/app_bottom_nav_bar.dart';
import '../../branch_locator/presentation/search_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../message/presentation/message_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const _pages = [
    HomeScreen(),
    SearchScreen(),
    MessageScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) =>
            ref.read(bottomNavIndexProvider.notifier).select(index),
      ),
    );
  }
}
