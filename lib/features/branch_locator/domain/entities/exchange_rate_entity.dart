class ExchangeRateEntity {
  final String countryCode;
  final String countryName;
  final String buy;
  final String sell;

  const ExchangeRateEntity({
    required this.countryCode,
    required this.countryName,
    required this.buy,
    required this.sell,
  });
}
