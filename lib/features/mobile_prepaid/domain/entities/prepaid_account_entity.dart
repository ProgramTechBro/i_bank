class PrepaidAccountEntity {
  final String cardBrand;
  final String maskedNumber;
  final double balance;

  const PrepaidAccountEntity({
    required this.cardBrand,
    required this.maskedNumber,
    required this.balance,
  });
}
