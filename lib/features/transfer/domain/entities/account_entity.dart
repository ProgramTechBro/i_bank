class AccountEntity {
  final String cardBrand;
  final String maskedNumber;
  final double balance;

  const AccountEntity({
    required this.cardBrand,
    required this.maskedNumber,
    required this.balance,
  });
}
