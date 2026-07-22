import '../../domain/entities/account_card_report_entity.dart';
import 'bank_account_model.dart';
import 'user_card_model.dart';

class AccountCardReportModel extends AccountCardReportEntity {
  const AccountCardReportModel({
    required super.userName,
    required super.avatarUrl,
    required List<BankAccountModel> super.accounts,
    required List<UserCardModel> super.cards,
  });
}
