import '../../../../core/enums/transaction_status.dart';

class PaymentHistoryEntryEntity {
  final String month;
  final DateTime date;
  final TransactionStatus status;
  final double amount;
  final String? company;

  const PaymentHistoryEntryEntity({
    required this.month,
    required this.date,
    required this.status,
    required this.amount,
    this.company,
  });
}
