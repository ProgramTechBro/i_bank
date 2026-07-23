import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/app_colors.dart';

class SaveOnlineListTile extends StatelessWidget {
  const SaveOnlineListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowPrimary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(iconAsset, width: 60),
          ],
        ),
      ),
    );
  }
}
