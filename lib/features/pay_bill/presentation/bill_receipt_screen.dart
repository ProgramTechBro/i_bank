import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/enums/bill_category.dart';
import '../../../core/enums/transaction_status.dart';
import '../../../core/extensions/bill_category_extension.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/payment_history_entry_entity.dart';
import 'local_widgets/bill_ticket_card.dart';
import 'providers/bill_details_provider.dart';

class BillReceiptScreen extends ConsumerWidget {
  const BillReceiptScreen({
    super.key,
    required this.category,
    required this.entry,
  });

  final BillCategory category;
  final PaymentHistoryEntryEntity entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(billDetailsProvider(category));

    return Scaffold(
      appBar: AppBar(title: Text('${category.tabLabel} payment')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: detailsAsync.when(
          data: (details) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BillTicketCard(category: category, details: details),
              if (entry.status == TransactionStatus.unsuccessful) ...[
                const SizedBox(height: 24),
                AppButton(
                  label: 'Pay the bill',
                  onPressed: () => context.push(
                    AppRoutes.billPay,
                    extra: {
                      'category': category,
                      'companyName': entry.company ?? '',
                      'billCode': details.code,
                    },
                  ),
                ),
              ],
            ],
          ),
          loading: () => const AppLoader(),
          error: (error, _) => AppErrorView(
            message: 'Something went wrong. Please try again.',
            onRetry: () => ref.invalidate(billDetailsProvider(category)),
          ),
        ),
      ),
    );
  }
}
