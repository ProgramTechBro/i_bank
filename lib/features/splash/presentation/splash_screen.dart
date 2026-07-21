import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_constants.dart';
import 'providers/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashTimerProvider, (previous, next) {
      if (next.hasValue) context.go(next.value!);
    });
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: Center(child: _SplashLogo())),
            const Padding(
              padding: EdgeInsets.only(bottom: 48),
              child: _SplashProgressBar(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppImages.splashLogo, height: 66);
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 8,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: AppConstants.splashDuration,
        curve: Curves.linear,
        builder: (context, value, _) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
