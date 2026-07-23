import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared_widgets/app_add_new_card_button.dart';
import '../../../core/shared_widgets/app_bank_card.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import 'providers/save_online_cards_provider.dart';

class ChooseCardScreen extends ConsumerWidget {
  const ChooseCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(saveOnlineCardsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Choose card')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: cardsAsync.when(
          data: (cards) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < cards.length; i++) ...[
                        GestureDetector(
                          onTap: () => context.pop(i),
                          child: AppBankCard(
                            cardHolderName: cards[i].holderName,
                            cardNickname: cards[i].nickname,
                            maskedCardNumber: cards[i].maskedNumber,
                            balance: cards[i].balance,
                            style: cards[i].style,
                            showShadowBars: false,
                          ),
                        ),
                        if (i != cards.length - 1) const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppAddNewCardButton(onTap: () {}),
            ],
          ),
          loading: () => const AppLoader(),
          error: (error, _) => AppErrorView(
            message: 'Something went wrong. Please try again.',
            onRetry: () => ref.invalidate(saveOnlineCardsProvider),
          ),
        ),
      ),
    );
  }
}
