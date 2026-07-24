import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/bottom_nav_provider.dart';
import '../../../core/shared_widgets/app_bottom_nav_bar.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/message_row_card.dart';
import 'providers/messages_provider.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesProvider);
    final selectedNavIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Message')),
      body: messagesAsync.when(
        data: (messages) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: messages.length,
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final message = messages[index];
            return MessageRowCard(
              message: message,
              onTap: message.hasThread
                  ? () => context.push(AppRoutes.messageThread)
                  : null,
            );
          },
        ),
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(messagesProvider),
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
