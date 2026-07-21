import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';

class HomeBalanceCard extends StatelessWidget {
  const HomeBalanceCard({
    super.key,
    required this.cardHolderName,
    required this.cardNickname,
    required this.maskedCardNumber,
    required this.balance,
  });

  final String cardHolderName;
  final String cardNickname;
  final String maskedCardNumber;
  final double balance;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedBalance = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
    ).format(balance);

    return SizedBox(
      height: 221,
      child: Stack(
        children: [
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
                    const ColoredBox(color: AppColors.cardIndigoMid),
                    Positioned(
                      right: -86,
                      top: -41,
                      child: _CircleBlob(
                        size: 190,
                        color: AppColors.cardSkyBlue,
                      ),
                    ),
                    Positioned(
                      left: -145,
                      top: -73,
                      child: _CircleBlob(
                        size: 381,
                        color: AppColors.cardIndigoDark,
                      ),
                    ),
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
                              Text(
                                'VISA',
                                style: textTheme.titleSmall?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
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
