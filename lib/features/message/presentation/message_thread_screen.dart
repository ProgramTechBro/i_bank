import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'local_widgets/chat_bubble.dart';
import 'providers/chat_thread_provider.dart';

class MessageThreadScreen extends ConsumerStatefulWidget {
  const MessageThreadScreen({super.key});

  @override
  ConsumerState<MessageThreadScreen> createState() =>
      _MessageThreadScreenState();
}

class _MessageThreadScreenState extends ConsumerState<MessageThreadScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    await ref.read(chatThreadNotifierProvider.notifier).sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatThreadNotifierProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Bank of America')),
      body: Column(
        children: [
          Expanded(
            child: state.messages.isEmpty
                ? const AppLoader()
                : ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (message.dateLabel != null) ...[
                            Text(
                              message.dateLabel!,
                              textAlign: TextAlign.center,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.neutral500,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          ChatBubble(message: message),
                          if (index != state.messages.length - 1)
                            const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: AnimatedBuilder(
              animation: _textController,
              builder: (context, _) {
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: TextField(
                          controller: _textController,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.neutral900,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type something....',
                            hintStyle: textTheme.labelLarge?.copyWith(
                              color: AppColors.neutral300,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.neutral300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _SendButton(
                      isEnabled: _textController.text.trim().isNotEmpty,
                      onTap: _send,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.isEnabled, required this.onTap});

  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary : AppColors.primaryTint,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward,
          size: 20,
          color: isEnabled ? AppColors.white : AppColors.neutral300,
        ),
      ),
    );
  }
}
