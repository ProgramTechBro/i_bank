class HomeDashboardEntity {
  final String userName;
  final String avatarUrl;
  final String cardHolderName;
  final String cardNickname;
  final String maskedCardNumber;
  final double balance;

  const HomeDashboardEntity({
    required this.userName,
    required this.avatarUrl,
    required this.cardHolderName,
    required this.cardNickname,
    required this.maskedCardNumber,
    required this.balance,
  });
}
