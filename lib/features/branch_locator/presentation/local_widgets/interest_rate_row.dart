import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/interest_rate_entity.dart';

class InterestRateRow extends StatelessWidget {
  const InterestRateRow({super.key, required this.interestRate});

  final InterestRateEntity interestRate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final rowStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.neutral900,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(interestRate.customerType, style: rowStyle),
          ),
          Expanded(
            child: Text(
              interestRate.deposit,
              textAlign: TextAlign.center,
              style: rowStyle,
            ),
          ),
          Expanded(
            child: Text(
              interestRate.rate,
              textAlign: TextAlign.right,
              style: rowStyle?.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
