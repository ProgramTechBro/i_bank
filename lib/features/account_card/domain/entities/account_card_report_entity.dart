import 'bank_account_entity.dart';
import 'user_card_entity.dart';

class AccountCardReportEntity {
  final String userName;
  final String avatarUrl;
  final List<BankAccountEntity> accounts;
  final List<UserCardEntity> cards;

  const AccountCardReportEntity({
    required this.userName,
    required this.avatarUrl,
    required this.accounts,
    required this.cards,
  });
}
