class CreditCardTransactionEntity {
  final String title;
  final DateTime date;
  final double amount;

  const CreditCardTransactionEntity({
    required this.title,
    required this.date,
    required this.amount,
  });
}
