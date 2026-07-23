import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class SaveOnlineSuccessScreen extends StatelessWidget {
  const SaveOnlineSuccessScreen({super.key});

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
                AppImages.saveOnlineIllustration,
                width: 324,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Save online successfully!',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Congratulations!\nYou have save money online successfully!',
              textAlign: TextAlign.center,
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.neutral900,
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'Confirm',
              onPressed: () => context.go(AppRoutes.home),
            ),
          ],
        ),
      ),
    );
  }
}
