import '../../domain/entities/bank_account_entity.dart';

class BankAccountModel extends BankAccountEntity {
  const BankAccountModel({
    required super.label,
    required super.number,
    required super.balance,
    required super.branch,
  });
}
