import '../../domain/entities/payment_history_entry_entity.dart';

class PaymentHistoryEntryModel extends PaymentHistoryEntryEntity {
  const PaymentHistoryEntryModel({
    required super.month,
    required super.date,
    required super.status,
    required super.amount,
    super.company,
  });
}
