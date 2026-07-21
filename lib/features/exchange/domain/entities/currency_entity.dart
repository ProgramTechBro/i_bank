class CurrencyEntity {
  final String code;
  final String symbol;
  final String name;
  final double rateToUsd;

  const CurrencyEntity({
    required this.code,
    required this.symbol,
    required this.name,
    required this.rateToUsd,
  });
}
