import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/transaction_type.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/usecases/add_beneficiary_usecase.dart';
import 'add_beneficiary_form_state.dart';

part 'add_beneficiary_form_provider.g.dart';

@riverpod
class AddBeneficiaryFormNotifier extends _$AddBeneficiaryFormNotifier {
  late final AddBeneficiaryUseCase _addBeneficiary =
      getIt<AddBeneficiaryUseCase>();

  @override
  AddBeneficiaryFormState build() => const AddBeneficiaryFormState();

  void selectTransferType(TransactionType type) =>
      state = state.copyWith(transferType: type);

  void selectBank(String bank) => state = state.copyWith(bank: bank);

  void selectBranch(String branch) => state = state.copyWith(branch: branch);

  Future<bool> submit({
    required String transactionName,
    required String cardNumber,
  }) async {
    state = state.copyWith(isSubmitting: true);
    final result = await _addBeneficiary(
      BeneficiaryEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: transactionName,
        number: cardNumber,
        avatarUrl: 'https://i.pravatar.cc/150?img=60',
        transferType: state.transferType,
        bank: state.transferType == TransactionType.otherBank
            ? state.bank
            : null,
        branch: state.transferType == TransactionType.otherBank
            ? state.branch
            : null,
        transactionName: transactionName,
        cardNumber: cardNumber,
      ),
    );
    state = state.copyWith(isSubmitting: false);
    return result.isRight();
  }
}
