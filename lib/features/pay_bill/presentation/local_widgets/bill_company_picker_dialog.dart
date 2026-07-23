import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/bill_company_entity.dart';

class BillCompanyPickerDialog extends StatelessWidget {
  const BillCompanyPickerDialog({super.key, required this.companies});

  final List<BillCompanyEntity> companies;

  static Future<int?> show(
    BuildContext context, {
    required List<BillCompanyEntity> companies,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => BillCompanyPickerDialog(companies: companies),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Choose company', style: textTheme.titleSmall),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(companies.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(index),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      companies[index].name,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
