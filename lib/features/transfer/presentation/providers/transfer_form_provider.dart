import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/enums/transaction_type.dart';
import 'transfer_form_state.dart';

part 'transfer_form_provider.g.dart';

@riverpod
class TransferFormNotifier extends _$TransferFormNotifier {
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
}
