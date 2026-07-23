import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/transaction_type.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_confirm_info_field.dart';
import '../domain/entities/beneficiary_entity.dart';

class BeneficiaryDetailScreen extends StatelessWidget {
  const BeneficiaryDetailScreen({super.key, required this.beneficiary});

  final BeneficiaryEntity beneficiary;

  static const double _avatarPeekHeight = 56;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isOtherBank = beneficiary.transferType == TransactionType.otherBank;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text('Beneficiary'),
      ),
      body: Stack(
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
                    padding: const EdgeInsets.fromLTRB(24, 96, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (isOtherBank) ...[
                          AppConfirmInfoField(
                            label: 'Choose bank',
                            value: beneficiary.bank ?? '',
                          ),
                          const SizedBox(height: 16),
                          AppConfirmInfoField(
                            label: 'Choose branch',
                            value: beneficiary.branch ?? '',
                          ),
                          const SizedBox(height: 16),
                        ],
                        AppConfirmInfoField(
                          label: 'Transaction name',
                          value: beneficiary.transactionName,
                        ),
                        const SizedBox(height: 16),
                        AppConfirmInfoField(
                          label: 'Card number',
                          value: beneficiary.cardNumber,
                        ),
                        const SizedBox(height: 24),
                        AppButton(
                          label: 'Confirm',
                          onPressed: () => context.pop(),
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
                  radius: 60,
                  backgroundImage: NetworkImage(beneficiary.avatarUrl),
                ),
                const SizedBox(height: 8),
                Text(
                  beneficiary.name,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
