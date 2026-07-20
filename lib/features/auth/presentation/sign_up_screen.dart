import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/request_status.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import 'local_widgets/terms_and_conditions_checkbox.dart';
import 'providers/sign_up_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFieldChanged(String _) {
    ref
        .read(signUpNotifierProvider.notifier)
        .validate(
          name: _nameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
  }

  void _onToggleTerms(bool value) {
    ref.read(signUpNotifierProvider.notifier).toggleAgreedToTerms();
    _onFieldChanged('');
  }

  Future<void> _onSubmit() async {
    final success = await ref
        .read(signUpNotifierProvider.notifier)
        .submit(
          name: _nameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final signUpState = ref.watch(signUpNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Sign up',
          style: textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to us,',
                style: textTheme.titleLarge?.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                'Hello there, create New account',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral900,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SvgPicture.asset(
                  AppImages.authSignUpIllustration,
                  width: 213,
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                controller: _nameController,
                hintText: 'Name',
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _phoneController,
                hintText: 'Text input',
                keyboardType: TextInputType.phone,
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: !signUpState.obscurePassword,
                showObscureToggle: true,
                onToggleObscure: () => ref
                    .read(signUpNotifierProvider.notifier)
                    .toggleObscurePassword(),
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 16),
              TermsAndConditionsCheckbox(
                value: signUpState.agreedToTerms,
                onChanged: _onToggleTerms,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Sign up',
                isLoading: signUpState.status == RequestStatus.loading,
                onPressed: signUpState.isFormValid ? _onSubmit : null,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      'Sign In',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
