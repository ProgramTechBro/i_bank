import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/managed_save_row_card.dart';
import 'providers/managed_saves_provider.dart';

class AccountManagementScreen extends ConsumerWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savesAsync = ref.watch(managedSavesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Management')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: savesAsync.when(
          data: (saves) => ListView.separated(
            itemCount: saves.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                ManagedSaveRowCard(save: saves[index]),
          ),
          loading: () => const AppLoader(),
          error: (error, _) => AppErrorView(
            message: 'Something went wrong. Please try again.',
            onRetry: () => ref.invalidate(managedSavesProvider),
          ),
        ),
      ),
    );
  }
}
