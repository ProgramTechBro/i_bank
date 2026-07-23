import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/bill_category.dart';
import '../../../core/extensions/bill_category_extension.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class BillPaymentSuccessScreen extends StatelessWidget {
  const BillPaymentSuccessScreen({super.key, required this.category});

  final BillCategory category;

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
                AppImages.payBillSuccessIllustration,
                width: 327,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Transaction successfully!',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              "You've pay your ${category.title.toLowerCase()}!",
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
