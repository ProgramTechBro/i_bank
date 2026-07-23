import 'package:injectable/injectable.dart';
import '../../../../../core/enums/transaction_type.dart';
import '../../../domain/entities/beneficiary_entity.dart';
import '../../models/beneficiary_model.dart';

abstract class BeneficiaryLocalDatasource {
  Future<List<BeneficiaryModel>> getBeneficiaries();

  Future<void> addBeneficiary(BeneficiaryEntity beneficiary);
}

@LazySingleton(as: BeneficiaryLocalDatasource)
class BeneficiaryLocalDatasourceImpl implements BeneficiaryLocalDatasource {
  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    return const [
      BeneficiaryModel(
        id: '1',
        name: 'Push',
        number: '12788980890',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        transferType: TransactionType.cardNumber,
        transactionName: 'Push',
        cardNumber: '12788980890',
      ),
      BeneficiaryModel(
        id: '2',
        name: 'Olivia',
        number: '0345976231',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        transferType: TransactionType.cardNumber,
        transactionName: 'Olivia',
        cardNumber: '0345976231',
      ),
      BeneficiaryModel(
        id: '3',
        name: 'Alexander',
        number: '12788980890',
        avatarUrl: 'https://i.pravatar.cc/150?img=13',
        transferType: TransactionType.sameBank,
        transactionName: 'Alexander',
        cardNumber: '12788980890',
      ),
      BeneficiaryModel(
        id: '4',
        name: 'Harper',
        number: '0345976231',
        avatarUrl: 'https://i.pravatar.cc/150?img=25',
        transferType: TransactionType.sameBank,
        transactionName: 'Harper',
        cardNumber: '0345976231',
      ),
      BeneficiaryModel(
        id: '5',
        name: 'Thomas',
        number: '12788980890',
        avatarUrl: 'https://i.pravatar.cc/150?img=52',
        transferType: TransactionType.otherBank,
        bank: 'Citibank',
        branch: 'New York',
        transactionName: 'Thomas',
        cardNumber: '12788980890',
      ),
      BeneficiaryModel(
        id: '6',
        name: 'Sanmatha',
        number: '0345976231',
        avatarUrl: 'https://i.pravatar.cc/150?img=32',
        transferType: TransactionType.otherBank,
        bank: 'Citibank',
        branch: 'New York',
        transactionName: 'Sanmatha',
        cardNumber: '0345976231',
      ),
      BeneficiaryModel(
        id: '7',
        name: 'Justin Biber',
        number: '12788980890',
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
        transferType: TransactionType.otherBank,
        bank: 'Citibank',
        branch: 'New York',
        transactionName: 'Justin Biber',
        cardNumber: '12788980890',
      ),
    ];
  }

  @override
  Future<void> addBeneficiary(BeneficiaryEntity beneficiary) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
