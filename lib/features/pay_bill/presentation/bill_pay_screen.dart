import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/bill_category.dart';
import '../../../core/extensions/bill_category_extension.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/bill_dropdown_field.dart';
import 'local_widgets/bill_ticket_card.dart';
import 'providers/bill_pay_provider.dart';

class BillPayScreen extends ConsumerStatefulWidget {
  const BillPayScreen({
    super.key,
    required this.category,
    required this.companyName,
    required this.billCode,
  });

  final BillCategory category;
  final String companyName;
  final String billCode;

  @override
  ConsumerState<BillPayScreen> createState() => _BillPayScreenState();
}

class _BillPayScreenState extends ConsumerState<BillPayScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = billPayNotifierProvider(
      widget.category,
      widget.companyName,
      widget.billCode,
    );
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final textTheme = Theme.of(context).textTheme;

    ref.listen(provider.select((s) => s.otp), (previous, next) {
      _otpController.text = next;
    });

    final billDetails = state.billDetails;

    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: billDetails == null
          ? const AppLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      AppImages.transferSuccessIllustration,
                      width: 327,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(billDetails.fromDate)} - '
                    '${DateFormat('dd/MM/yyyy').format(billDetails.toDate)}',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BillTicketCard(
                    category: widget.category,
                    details: billDetails,
                  ),
                  const SizedBox(height: 24),
                  BillDropdownField(
                    value: state.selectedAccountNumber,
                    placeholder: 'Choose account/ card',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get OTP to verify transaction',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _otpController,
                          hintText: 'OTP',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 90,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Get OTP',
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Pay the bill',
                    isLoading: state.isSubmitting,
                    onPressed: () async {
                      final success = await notifier.submit();
                      if (success && context.mounted) {
                        context.go(
                          AppRoutes.billPaymentSuccess,
                          extra: widget.category,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
