import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../../domain/entities/prepaid_recharge_entity.dart';
import '../../models/prepaid_account_model.dart';
import '../../models/prepaid_beneficiary_model.dart';

abstract class MobilePrepaidLocalDatasource {
  Future<List<PrepaidBeneficiaryModel>> getBeneficiaries();

  Future<List<PrepaidAccountModel>> getAccounts();

  Future<void> submitRecharge(PrepaidRechargeEntity recharge);
}

@LazySingleton(as: MobilePrepaidLocalDatasource)
class MobilePrepaidLocalDatasourceImpl implements MobilePrepaidLocalDatasource {
  @override
  Future<List<PrepaidBeneficiaryModel>> getBeneficiaries() async {
    return const [
      PrepaidBeneficiaryModel(
        id: '1',
        name: 'Emma',
        avatarUrl: AppNetworkImages.beneficiaryEmma,
        phoneNumber: '+8564757899',
      ),
      PrepaidBeneficiaryModel(
        id: '2',
        name: 'Justin',
        avatarUrl: AppNetworkImages.beneficiaryJustin,
        phoneNumber: '+1234567890',
      ),
    ];
  }

  @override
  Future<List<PrepaidAccountModel>> getAccounts() async {
    return const [
      PrepaidAccountModel(
        cardBrand: 'VISA',
        maskedNumber: '**** **** **** 1234',
        balance: 10000,
      ),
    ];
  }

  @override
  Future<void> submitRecharge(PrepaidRechargeEntity recharge) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
