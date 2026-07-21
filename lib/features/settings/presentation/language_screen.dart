import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/language_row.dart';
import 'providers/languages_provider.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languagesAsync = ref.watch(languagesProvider);
    final selectedIndex = ref.watch(selectedLanguageIndexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Language')),
      body: languagesAsync.when(
        data: (languages) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: languages.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) => LanguageRow(
            language: languages[index],
            isSelected: index == selectedIndex,
            onTap: () =>
                ref.read(selectedLanguageIndexProvider.notifier).select(index),
          ),
        ),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(languagesProvider),
        ),
      ),
    );
  }
}
