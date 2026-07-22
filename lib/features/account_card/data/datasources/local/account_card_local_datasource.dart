import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../../../../core/enums/bank_card_style.dart';
import '../../models/account_card_report_model.dart';
import '../../models/bank_account_model.dart';
import '../../models/user_card_model.dart';

abstract class AccountCardLocalDatasource {
  Future<AccountCardReportModel> getAccountCardReport();
}

@LazySingleton(as: AccountCardLocalDatasource)
class AccountCardLocalDatasourceImpl implements AccountCardLocalDatasource {
  @override
  Future<AccountCardReportModel> getAccountCardReport() async {
    return const AccountCardReportModel(
      userName: 'Push Puttichai',
      avatarUrl: AppNetworkImages.currentUserAvatar,
      accounts: [
        BankAccountModel(
          label: 'Account 1',
          number: '1900 8988 1234',
          balance: 20000,
          branch: 'New York',
        ),
        BankAccountModel(
          label: 'Account 2',
          number: '8988 1234',
          balance: 12000,
          branch: 'New York',
        ),
        BankAccountModel(
          label: 'Account 3',
          number: '1900 1234 2222',
          balance: 230000,
          branch: 'New York',
        ),
      ],
      cards: [
        UserCardModel(
          holderName: 'John Smith',
          nickname: 'Amazon Platinium',
          maskedNumber: '4756  ••••  ••••  9018',
          balance: 3469.52,
          style: BankCardStyle.blue,
        ),
        UserCardModel(
          holderName: 'John Smith',
          nickname: 'Amazon Platinium',
          maskedNumber: '4756  ••••  ••••  9018',
          balance: 3469.52,
          style: BankCardStyle.orange,
        ),
      ],
    );
  }
}
