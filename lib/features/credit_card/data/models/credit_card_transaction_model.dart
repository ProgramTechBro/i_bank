import '../../domain/entities/credit_card_transaction_entity.dart';

class CreditCardTransactionModel extends CreditCardTransactionEntity {
  const CreditCardTransactionModel({
    required super.title,
    required super.date,
    required super.amount,
  });
}
