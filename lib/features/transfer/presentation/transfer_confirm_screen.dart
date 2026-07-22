import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/transfer_entity.dart';
import 'local_widgets/confirm_info_field.dart';
import 'local_widgets/face_id_scan_widget.dart';
import 'local_widgets/fingerprint_scan_widget.dart';
import 'local_widgets/touch_id_dialog.dart';
import 'providers/transfer_confirm_provider.dart';
import 'providers/transfer_confirm_state.dart';

class TransferConfirmScreen extends ConsumerStatefulWidget {
  const TransferConfirmScreen({
    super.key,
    required this.transfer,
    required this.fromMasked,
    required this.toName,
  });

  final TransferEntity transfer;
  final String fromMasked;
  final String toName;

  @override
  ConsumerState<TransferConfirmScreen> createState() =>
      _TransferConfirmScreenState();
}

class _TransferConfirmScreenState extends ConsumerState<TransferConfirmScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _onFingerprintTap() async {
    final notifier = ref.read(
      transferConfirmNotifierProvider(widget.transfer).notifier,
    );
    notifier.startFingerprintScan();

    final resultFuture = showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const TouchIdDialog(),
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
    final provider = transferConfirmNotifierProvider(widget.transfer);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final textTheme = Theme.of(context).textTheme;

    ref.listen(provider.select((s) => s.otp), (previous, next) {
      _otpController.text = next;
    });

    ref.listen(provider.select((s) => s.faceMatched), (previous, matched) {
      if (matched) {
        Future.delayed(const Duration(milliseconds: 700), () {
          if (!context.mounted) return;
          context.go(
            AppRoutes.transferSuccess,
            extra: {'amount': widget.transfer.amount, 'toName': widget.toName},
          );
        });
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
            ConfirmInfoField(label: 'From', value: widget.fromMasked),
            const SizedBox(height: 16),
            ConfirmInfoField(label: 'To', value: widget.toName),
            if (state.step == ConfirmStep.faceId) ...[
              const SizedBox(height: 16),
              const ConfirmInfoField(
                label: 'Beneficiary bank',
                value: 'US bank',
              ),
            ],
            const SizedBox(height: 16),
            ConfirmInfoField(
              label: 'Card number',
              value: widget.transfer.cardNumber,
            ),
            const SizedBox(height: 16),
            const ConfirmInfoField(label: 'Transaction fee', value: '10\$'),
            const SizedBox(height: 16),
            ConfirmInfoField(label: 'Content', value: widget.transfer.content),
            const SizedBox(height: 16),
            ConfirmInfoField(
              label: 'Amount',
              value: '\$${widget.transfer.amount.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 24),
            switch (state.step) {
              ConfirmStep.otp => _OtpStep(
                otpController: _otpController,
                onConfirm: notifier.confirmOtp,
              ),
              ConfirmStep.fingerprint => _FingerprintStep(
                isScanning: state.isScanningFingerprint,
                isVerified: state.fingerprintVerified,
                onTap: _onFingerprintTap,
                onConfirm: notifier.confirmFingerprint,
              ),
              ConfirmStep.faceId => _FaceIdStep(isMatched: state.faceMatched),
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
    return Column(
      children: [
        Center(
          child: FingerprintScanWidget(
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

class _FaceIdStep extends StatelessWidget {
  const _FaceIdStep({required this.isMatched});

  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          'Use Face ID to verify transaction',
          style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 16),
        Center(child: FaceIdScanWidget(isMatched: isMatched)),
        const SizedBox(height: 24),
        const AppButton(label: 'Confirm', onPressed: null),
      ],
    );
  }
}
