import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/request_status.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import 'providers/change_password_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFieldChanged(String _) {
    ref
        .read(changePasswordNotifierProvider.notifier)
        .validate(
          newPassword: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
  }

  Future<void> _onSubmit() async {
    final success = await ref
        .read(changePasswordNotifierProvider.notifier)
        .submit(_newPasswordController.text);
    if (success && mounted) context.push(AppRoutes.changePasswordSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Change password')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: AppColors.cardShadowPrimary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: _newPasswordController,
                label: 'Type your new password',
                obscureText: !state.obscureNewPassword,
                showObscureToggle: true,
                onToggleObscure: () => ref
                    .read(changePasswordNotifierProvider.notifier)
                    .toggleObscureNewPassword(),
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _confirmPasswordController,
                label: 'Confirm password',
                obscureText: !state.obscureConfirmPassword,
                showObscureToggle: true,
                onToggleObscure: () => ref
                    .read(changePasswordNotifierProvider.notifier)
                    .toggleObscureConfirmPassword(),
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Change password',
                isLoading: state.status == RequestStatus.loading,
                onPressed: state.isFormValid ? _onSubmit : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
