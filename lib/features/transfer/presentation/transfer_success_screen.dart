import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class TransferSuccessScreen extends StatefulWidget {
  const TransferSuccessScreen({
    super.key,
    required this.amount,
    required this.toName,
  });

  final double amount;
  final String toName;

  @override
  State<TransferSuccessScreen> createState() => _TransferSuccessScreenState();
}

class _TransferSuccessScreenState extends State<TransferSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<double> _scale = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.6, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              child: ScaleTransition(
                scale: _scale,
                child: FadeTransition(
                  opacity: _fade,
                  child: SvgPicture.asset(
                    AppImages.transferSuccessIllustration,
                    width: 327,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Transfer successful!',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                style: textTheme.labelLarge?.copyWith(
                  color: AppColors.neutral900,
                ),
                children: [
                  const TextSpan(
                    text: 'You have successfully transferred ',
                  ),
                  TextSpan(
                    text: '\$${widget.amount.toStringAsFixed(0)}',
                    style: const TextStyle(color: AppColors.semanticError),
                  ),
                  const TextSpan(text: ' to '),
                  TextSpan(
                    text: '${widget.toName}!',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
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
