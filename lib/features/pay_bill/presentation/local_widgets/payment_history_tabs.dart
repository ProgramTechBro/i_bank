import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/extensions/bill_category_extension.dart';

class PaymentHistoryTabs extends StatelessWidget {
  const PaymentHistoryTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final BillCategory selected;
  final ValueChanged<BillCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: BillCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = BillCategory.values[index];
          final isSelected = category == selected;
          return GestureDetector(
            onTap: () => onChanged(category),
            child: Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.primaryTint,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                category.tabLabel,
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.white : AppColors.neutral900,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
