import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/request_status.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import 'providers/sign_in_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFieldChanged(String _) {
    ref
        .read(signInNotifierProvider.notifier)
        .validate(
          identifier: _identifierController.text,
          password: _passwordController.text,
        );
  }

  Future<void> _onSubmit() async {
    final success = await ref
        .read(signInNotifierProvider.notifier)
        .submit(
          identifier: _identifierController.text,
          password: _passwordController.text,
        );
    if (success && mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final signInState = ref.watch(signInNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Sign in',
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
                'Welcome Back',
                style: textTheme.titleLarge?.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                'Hello there, sign in to continue',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral900,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SvgPicture.asset(AppImages.authSignInIllustration, width: 213),
              ),
              const SizedBox(height: 24),
              AppTextField(
                controller: _identifierController,
                hintText: 'Text input',
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: !signInState.obscurePassword,
                showObscureToggle: true,
                onToggleObscure: () => ref
                    .read(signInNotifierProvider.notifier)
                    .toggleObscurePassword(),
                onChanged: _onFieldChanged,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.forgotPassword),
                  child: Text(
                    'Forgot your password ?',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral300,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Sign in',
                isLoading: signInState.status == RequestStatus.loading,
                onPressed: signInState.isFormValid ? _onSubmit : null,
              ),
              const SizedBox(height: 24),
              const Center(
                child: Icon(
                  Icons.fingerprint,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.signUp),
                    child: Text(
                      'Sign Up',
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
