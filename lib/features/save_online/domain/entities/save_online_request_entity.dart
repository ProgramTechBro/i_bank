class SaveOnlineRequestEntity {
  final String accountLabel;
  final int depositMonths;
  final double interestRate;
  final double amount;

  const SaveOnlineRequestEntity({
    required this.accountLabel,
    required this.depositMonths,
    required this.interestRate,
    required this.amount,
  });
}
