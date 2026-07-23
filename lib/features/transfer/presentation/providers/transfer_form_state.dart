import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/transaction_type.dart';

part 'transfer_form_state.freezed.dart';

@freezed
class TransferFormState with _$TransferFormState {
  const factory TransferFormState({
    int? selectedAccountIndex,
    @Default(TransactionType.cardNumber) TransactionType transactionType,
    int? selectedBeneficiaryIndex,
    @Default(false) bool saveToDirectory,
  }) = _TransferFormState;
}
