import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/request_status.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/forgot_password_code_step.dart';
import 'local_widgets/forgot_password_phone_step.dart';
import 'providers/forgot_password_provider.dart';
import 'providers/forgot_password_state.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _onSend() async {
    await ref
        .read(forgotPasswordNotifierProvider.notifier)
        .sendCode(_phoneController.text);
  }

  Future<void> _onChangePassword() async {
    final success = await ref
        .read(forgotPasswordNotifierProvider.notifier)
        .verifyCode(_codeController.text);
    if (success && mounted) context.push(AppRoutes.changePassword);
  }

  void _onChangePhoneNumber() {
    _codeController.clear();
    ref.read(forgotPasswordNotifierProvider.notifier).backToPhoneStep();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordNotifierProvider);
    final isLoading = state.status == RequestStatus.loading;

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: AppColors.cardShadowPrimary,
          ),
          child: state.step == ForgotPasswordStep.phone
              ? ForgotPasswordPhoneStep(
                  phoneController: _phoneController,
                  onPhoneChanged: (value) => ref
                      .read(forgotPasswordNotifierProvider.notifier)
                      .validatePhone(value),
                  isSending: isLoading,
                  onSend: _onSend,
                )
              : ForgotPasswordCodeStep(
                  phone: state.phone,
                  codeController: _codeController,
                  onCodeChanged: (value) => ref
                      .read(forgotPasswordNotifierProvider.notifier)
                      .validateCode(value),
                  isSubmitting: isLoading,
                  onChangePassword: _onChangePassword,
                  onResend: () => ref
                      .read(forgotPasswordNotifierProvider.notifier)
                      .resendCode(),
                  onChangePhoneNumber: _onChangePhoneNumber,
                ),
        ),
      ),
    );
  }
}
