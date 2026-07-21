import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/transaction_type.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/usecases/send_transfer_usecase.dart';
import 'transfer_form_state.dart';

part 'transfer_form_provider.g.dart';

@riverpod
class TransferFormNotifier extends _$TransferFormNotifier {
  late final SendTransferUseCase _sendTransfer = getIt<SendTransferUseCase>();

  @override
  TransferFormState build() => const TransferFormState();

  void selectAccount(int index) =>
      state = state.copyWith(selectedAccountIndex: index);

  void selectTransactionType(TransactionType type) =>
      state = state.copyWith(transactionType: type);

  void selectBeneficiary(int index) => state = state.copyWith(
    selectedBeneficiaryIndex: index == state.selectedBeneficiaryIndex
        ? null
        : index,
  );

  void toggleSaveToDirectory() =>
      state = state.copyWith(saveToDirectory: !state.saveToDirectory);

  Future<bool> submit({
    required String name,
    required String cardNumber,
    required String amount,
    required String content,
  }) async {
    state = state.copyWith(status: RequestStatus.loading);
    final transfer = TransferEntity(
      name: name,
      cardNumber: cardNumber,
      amount: double.tryParse(amount) ?? 0,
      content: content,
      transactionType: state.transactionType,
    );
    final result = await _sendTransfer(transfer);
    return result.fold(
      (failure) {
        state = state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(status: RequestStatus.success);
        return true;
      },
    );
  }
}
