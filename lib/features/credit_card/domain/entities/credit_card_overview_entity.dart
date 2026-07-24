import 'credit_card_entity.dart';
import 'credit_card_transaction_entity.dart';

class CreditCardOverviewEntity {
  final CreditCardEntity card;
  final List<CreditCardTransactionEntity> transactions;
  final double total;

  const CreditCardOverviewEntity({
    required this.card,
    required this.transactions,
    required this.total,
  });
}
