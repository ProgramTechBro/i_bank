import 'transaction_type.dart';

class TransferEntity {
  final String name;
  final String cardNumber;
  final double amount;
  final String content;
  final TransactionType transactionType;

  const TransferEntity({
    required this.name,
    required this.cardNumber,
    required this.amount,
    required this.content,
    required this.transactionType,
  });
}
