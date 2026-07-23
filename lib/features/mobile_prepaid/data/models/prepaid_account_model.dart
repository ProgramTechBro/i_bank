import '../../domain/entities/prepaid_account_entity.dart';

class PrepaidAccountModel extends PrepaidAccountEntity {
  const PrepaidAccountModel({
    required super.cardBrand,
    required super.maskedNumber,
    required super.balance,
  });
}
