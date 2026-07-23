import 'package:injectable/injectable.dart';
import '../../../../../core/enums/bank_card_style.dart';
import '../../../domain/entities/save_online_request_entity.dart';
import '../../models/managed_save_model.dart';
import '../../models/save_online_card_model.dart';
import '../../models/time_deposit_option_model.dart';

abstract class SaveOnlineLocalDatasource {
  Future<List<SaveOnlineCardModel>> getCards();

  Future<List<TimeDepositOptionModel>> getTimeDepositOptions();

  Future<void> submitSaveOnline(SaveOnlineRequestEntity request);

  Future<List<ManagedSaveModel>> getManagedSaves();
}

@LazySingleton(as: SaveOnlineLocalDatasource)
class SaveOnlineLocalDatasourceImpl implements SaveOnlineLocalDatasource {
  @override
  Future<List<SaveOnlineCardModel>> getCards() async {
    return const [
      SaveOnlineCardModel(
        holderName: 'John Smith',
        nickname: 'Amazon Platinium',
        maskedNumber: '4756  ••••  ••••  9018',
        balance: 3469.52,
        style: BankCardStyle.blue,
      ),
      SaveOnlineCardModel(
        holderName: 'John Smith',
        nickname: 'Amazon Platinium',
        maskedNumber: '4756  ••••  ••••  9018',
        balance: 3469.52,
        style: BankCardStyle.orange,
      ),
    ];
  }

  @override
  Future<List<TimeDepositOptionModel>> getTimeDepositOptions() async {
    return const [
      TimeDepositOptionModel(months: 3, interestRate: 4),
      TimeDepositOptionModel(months: 6, interestRate: 4.5),
      TimeDepositOptionModel(months: 12, interestRate: 5),
      TimeDepositOptionModel(months: 16, interestRate: 5.5),
      TimeDepositOptionModel(months: 24, interestRate: 6),
    ];
  }

  @override
  Future<void> submitSaveOnline(SaveOnlineRequestEntity request) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<ManagedSaveModel>> getManagedSaves() async {
    final from = DateTime(2019, 11, 2);
    final to = DateTime(2020, 11, 2);
    return [
      ManagedSaveModel(
        accountNumber: '1900 8988 5456',
        fromDate: from,
        toDate: to,
        depositMonths: 12,
        interestRate: 5,
      ),
      ManagedSaveModel(
        accountNumber: '1900 8112 5222',
        fromDate: from,
        toDate: to,
        depositMonths: 12,
        interestRate: 5,
      ),
      ManagedSaveModel(
        accountNumber: '4411 0000 1234',
        fromDate: from,
        toDate: to,
        depositMonths: 12,
        interestRate: 5,
      ),
    ];
  }
}
