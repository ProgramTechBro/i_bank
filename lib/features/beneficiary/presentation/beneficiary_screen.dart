import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/transaction_type.dart';
import '../../../core/extensions/transaction_type_extension.dart';
import '../../../core/shared_widgets/app_error_view.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/beneficiary_row.dart';
import 'providers/beneficiaries_provider.dart';

class BeneficiaryScreen extends ConsumerWidget {
  const BeneficiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiariesAsync = ref.watch(beneficiariesProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiary'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.neutral900),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(AppRoutes.beneficiaryAdd),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: beneficiariesAsync.when(
        data: (beneficiaries) {
          final grouped = <TransactionType, List<int>>{};
          for (var i = 0; i < beneficiaries.length; i++) {
            grouped
                .putIfAbsent(beneficiaries[i].transferType, () => [])
                .add(i);
          }

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              for (final type in TransactionType.values)
                if (grouped[type] != null) ...[
                  Text(
                    type.beneficiaryGroupLabel,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: AppColors.cardShadowPrimary,
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < grouped[type]!.length; i++)
                          BeneficiaryRow(
                            beneficiary: beneficiaries[grouped[type]![i]],
                            showDivider: i != grouped[type]!.length - 1,
                            onTap: () => context.push(
                              AppRoutes.beneficiaryDetail,
                              extra: beneficiaries[grouped[type]![i]],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(beneficiariesProvider),
        ),
      ),
    );
  }
}
