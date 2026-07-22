import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.title,
    required super.amount,
    required super.date,
    required super.direction,
    required super.category,
    super.status,
  });
}
