import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/exchange_rate_entity.dart';

class ExchangeRateRow extends StatelessWidget {
  const ExchangeRateRow({super.key, required this.exchangeRate});

  final ExchangeRateEntity exchangeRate;

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
          CountryFlag.fromCountryCode(
            exchangeRate.countryCode,
            height: 24,
            width: 32,
            shape: const RoundedRectangle(4),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(exchangeRate.countryName, style: rowStyle),
          ),
          Expanded(
            child: Text(
              exchangeRate.buy,
              textAlign: TextAlign.center,
              style: rowStyle,
            ),
          ),
          Expanded(
            child: Text(
              exchangeRate.sell,
              textAlign: TextAlign.right,
              style: rowStyle,
            ),
          ),
        ],
      ),
    );
  }
}
