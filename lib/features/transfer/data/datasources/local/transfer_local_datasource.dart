import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../../domain/entities/transfer_entity.dart';
import '../../models/account_model.dart';
import '../../models/beneficiary_model.dart';

abstract class TransferLocalDatasource {
  Future<List<BeneficiaryModel>> getBeneficiaries();

  Future<List<AccountModel>> getAccounts();

  Future<void> sendTransfer(TransferEntity transfer);
}

@LazySingleton(as: TransferLocalDatasource)
class TransferLocalDatasourceImpl implements TransferLocalDatasource {
  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    return const [
      BeneficiaryModel(
        id: '1',
        name: 'Emma',
        avatarUrl: AppNetworkImages.beneficiaryEmma,
      ),
      BeneficiaryModel(
        id: '2',
        name: 'Justin',
        avatarUrl: AppNetworkImages.beneficiaryJustin,
      ),
      BeneficiaryModel(
        id: '3',
        name: 'Amanda',
        avatarUrl: AppNetworkImages.beneficiaryAmanda,
      ),
    ];
  }

  @override
  Future<List<AccountModel>> getAccounts() async {
    return const [
      AccountModel(
        cardBrand: 'VISA',
        maskedNumber: '**** **** **** 1234',
        balance: 10000,
      ),
    ];
  }

  @override
  Future<void> sendTransfer(TransferEntity transfer) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
