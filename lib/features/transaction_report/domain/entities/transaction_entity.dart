import '../../../../core/enums/transaction_category.dart';
import '../../../../core/enums/transaction_direction.dart';
import '../../../../core/enums/transaction_status.dart';

class TransactionEntity {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionDirection direction;
  final TransactionCategory category;
  final TransactionStatus? status;

  const TransactionEntity({
    required this.title,
    required this.amount,
    required this.date,
    required this.direction,
    required this.category,
    this.status,
  });
}
