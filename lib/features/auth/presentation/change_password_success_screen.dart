import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  const ChangePasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SvgPicture.asset(
                AppImages.changePasswordSuccessIllustration,
                width: 327,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Change password successfully!',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'You have successfully change password.\nPlease use the new password when Sign in.',
              textAlign: TextAlign.center,
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.neutral900,
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'Ok',
              onPressed: () => context.go(AppRoutes.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
