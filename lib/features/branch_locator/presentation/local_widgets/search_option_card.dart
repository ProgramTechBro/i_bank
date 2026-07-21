import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/app_colors.dart';

class SearchOptionCard extends StatelessWidget {
  const SearchOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustrationAsset,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String illustrationAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(illustrationAsset, width: 100, height: 80),
          ],
        ),
      ),
    );
  }
}
