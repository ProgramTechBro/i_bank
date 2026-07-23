import '../../../../core/enums/transaction_type.dart';

class BeneficiaryEntity {
  final String id;
  final String name;
  final String number;
  final String avatarUrl;
  final TransactionType transferType;
  final String? bank;
  final String? branch;
  final String transactionName;
  final String cardNumber;

  const BeneficiaryEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.avatarUrl,
    required this.transferType,
    this.bank,
    this.branch,
    required this.transactionName,
    required this.cardNumber,
  });
}
