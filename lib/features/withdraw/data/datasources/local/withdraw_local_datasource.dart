import 'package:injectable/injectable.dart';
import '../../../domain/entities/withdraw_entity.dart';
import '../../models/withdraw_account_model.dart';

abstract class WithdrawLocalDatasource {
  Future<List<WithdrawAccountModel>> getAccounts();

  Future<void> submitWithdrawal(WithdrawEntity withdrawal);
}

@LazySingleton(as: WithdrawLocalDatasource)
class WithdrawLocalDatasourceImpl implements WithdrawLocalDatasource {
  @override
  Future<List<WithdrawAccountModel>> getAccounts() async {
    return const [
      WithdrawAccountModel(number: '1900 8988 5456', balance: 5000),
      WithdrawAccountModel(number: '1900 8112 5222', balance: 7500),
      WithdrawAccountModel(number: '4411 0000 1234', balance: 10000),
      WithdrawAccountModel(number: '1900 8988 5456', balance: 3200),
      WithdrawAccountModel(number: '1900 8988 5456', balance: 4800),
    ];
  }

  @override
  Future<void> submitWithdrawal(WithdrawEntity withdrawal) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
