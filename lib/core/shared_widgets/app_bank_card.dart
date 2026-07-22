import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../enums/bank_card_style.dart';

class AppBankCard extends StatelessWidget {
  const AppBankCard({
    super.key,
    required this.cardHolderName,
    required this.cardNickname,
    required this.maskedCardNumber,
    required this.balance,
    this.style = BankCardStyle.blue,
    this.showShadowBars = true,
  });

  final String cardHolderName;
  final String cardNickname;
  final String maskedCardNumber;
  final double balance;
  final BankCardStyle style;
  final bool showShadowBars;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedBalance = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
    ).format(balance);

    return SizedBox(
      height: showShadowBars ? 221 : 204,
      child: Stack(
        children: [
          if (showShadowBars) ...[
            Positioned(
              top: 188,
              left: 33,
              right: 33,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: AppColors.cardShadowPrimary,
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 20,
              right: 20,
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.semanticError,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: AppColors.cardShadowPrimary,
                ),
              ),
            ),
          ],
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 204,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ..._buildBackground(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 21, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cardHolderName,
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            cardNickname,
                            style: textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            maskedCardNumber,
                            style: textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formattedBalance,
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              _buildLogo(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackground() {
    switch (style) {
      case BankCardStyle.blue:
        return [
          const ColoredBox(color: AppColors.cardIndigoMid),
          Positioned(
            right: -86,
            top: -51,
            child: _CircleBlob(size: 190, color: AppColors.cardSkyBlue),
          ),
          Positioned(
            left: -175,
            top: -53,
            child: _CircleBlob(size: 420, color: AppColors.cardIndigoDark),
          ),
        ];
      case BankCardStyle.orange:
        final midBlob = Color.lerp(
          AppColors.semanticWarning,
          AppColors.white,
          0.15,
        )!;
        final lightCorner = Color.lerp(
          AppColors.semanticWarning,
          AppColors.white,
          0.35,
        )!;
        final softDot = Color.lerp(
          AppColors.semanticWarning,
          AppColors.white,
          0.5,
        )!;
        return [
          const ColoredBox(color: AppColors.semanticWarning),
          Positioned(
            left: -140,
            top: -90,
            child: _CircleBlob(size: 420, color: midBlob),
          ),
          Positioned(
            left: -30,
            top: -80,
            child: _CircleBlob(size: 170, color: lightCorner),
          ),
          Positioned(
            right: 140,
            top: 60,
            child: _CircleBlob(size: 28, color: softDot),
          ),
          Positioned(
            right: 210,
            top: 110,
            child: _CircleBlob(size: 60, color: softDot),
          ),
        ];
    }
  }

  Widget _buildLogo() {
    switch (style) {
      case BankCardStyle.blue:
        return SvgPicture.asset(
          AppIcons.homeCardVisa,
          height: 16,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        );
      case BankCardStyle.orange:
        return const _OverlappingCirclesLogo();
    }
  }
}

class _CircleBlob extends StatelessWidget {
  const _CircleBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _OverlappingCirclesLogo extends StatelessWidget {
  const _OverlappingCirclesLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 12,
            child: _CircleBlob(
              size: 28,
              color: AppColors.white.withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            left: -3,
            child: _CircleBlob(size: 28, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
