import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/extensions/bill_category_extension.dart';

class BillCategoryTile extends StatelessWidget {
  const BillCategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  final BillCategory category;
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
                  Text(category.title, style: textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    category.subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(category.illustrationAsset, width: 90),
          ],
        ),
      ),
    );
  }
}
