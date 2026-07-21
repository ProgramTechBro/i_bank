import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required super.cardBrand,
    required super.maskedNumber,
    required super.balance,
  });
}
