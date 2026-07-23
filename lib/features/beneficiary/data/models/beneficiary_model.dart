import '../../domain/entities/beneficiary_entity.dart';

class BeneficiaryModel extends BeneficiaryEntity {
  const BeneficiaryModel({
    required super.id,
    required super.name,
    required super.number,
    required super.avatarUrl,
    required super.transferType,
    super.bank,
    super.branch,
    required super.transactionName,
    required super.cardNumber,
  });
}
