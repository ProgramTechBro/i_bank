import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/language_entity.dart';

class LanguageRow extends StatelessWidget {
  const LanguageRow({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final LanguageEntity language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            CountryFlag.fromCountryCode(
              language.code,
              height: 30,
              width: 40,
              shape: const RoundedRectangle(4),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                language.name,
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? AppColors.neutral900
                      : AppColors.neutral500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
