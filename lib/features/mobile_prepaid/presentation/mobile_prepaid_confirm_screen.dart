import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_confirm_info_field.dart';
import '../../../core/shared_widgets/app_fingerprint_scan_widget.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../core/shared_widgets/app_touch_id_dialog.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/prepaid_recharge_entity.dart';
import 'providers/prepaid_confirm_provider.dart';
import 'providers/prepaid_confirm_state.dart';

class MobilePrepaidConfirmScreen extends ConsumerStatefulWidget {
  const MobilePrepaidConfirmScreen({
    super.key,
    required this.recharge,
    required this.fromMasked,
  });

  final PrepaidRechargeEntity recharge;
  final String fromMasked;

  @override
  ConsumerState<MobilePrepaidConfirmScreen> createState() =>
      _MobilePrepaidConfirmScreenState();
}

class _MobilePrepaidConfirmScreenState
    extends ConsumerState<MobilePrepaidConfirmScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _onFingerprintTap() async {
    final notifier = ref.read(
      prepaidConfirmNotifierProvider(widget.recharge).notifier,
    );
    notifier.startFingerprintScan();

    final resultFuture = showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AppTouchIdDialog(),
    );
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop(true);
      }
    });

    final verified = await resultFuture;
    if (verified == true) {
      await notifier.verifyFingerprint();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = prepaidConfirmNotifierProvider(widget.recharge);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final textTheme = Theme.of(context).textTheme;

    ref.listen(provider.select((s) => s.otp), (previous, next) {
      _otpController.text = next;
    });

    ref.listen(provider.select((s) => s.isSubmitted), (previous, submitted) {
      if (submitted) {
        context.go(AppRoutes.mobilePrepaidSuccess);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Confirm transaction information',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.neutral500,
              ),
            ),
            const SizedBox(height: 16),
            AppConfirmInfoField(label: 'From', value: widget.fromMasked),
            const SizedBox(height: 16),
            AppConfirmInfoField(label: 'To', value: widget.recharge.phoneNumber),
            const SizedBox(height: 16),
            AppConfirmInfoField(
              label: 'Amount',
              value: '\$${widget.recharge.amount.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 24),
            switch (state.step) {
              PrepaidConfirmStep.otp => _OtpStep(
                otpController: _otpController,
                onConfirm: notifier.confirmOtp,
              ),
              PrepaidConfirmStep.fingerprint => _FingerprintStep(
                isScanning: state.isScanningFingerprint,
                isVerified: state.fingerprintVerified,
                onTap: _onFingerprintTap,
                onConfirm: notifier.confirmFingerprint,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _OtpStep extends StatelessWidget {
  const _OtpStep({required this.otpController, required this.onConfirm});

  final TextEditingController otpController;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get OTP to verify transaction',
          style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                controller: otpController,
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
        AppButton(label: 'Confirm', onPressed: onConfirm),
      ],
    );
  }
}

class _FingerprintStep extends StatelessWidget {
  const _FingerprintStep({
    required this.isScanning,
    required this.isVerified,
    required this.onTap,
    required this.onConfirm,
  });

  final bool isScanning;
  final bool isVerified;
  final VoidCallback onTap;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          'Use Touch ID to verify transaction',
          style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 16),
        Center(
          child: AppFingerprintScanWidget(
            isScanning: isScanning,
            isVerified: isVerified,
            onTap: onTap,
          ),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Confirm', onPressed: isVerified ? onConfirm : null),
      ],
    );
  }
}
