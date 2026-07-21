import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/transaction_type.dart';

part 'transfer_form_state.freezed.dart';

@freezed
class TransferFormState with _$TransferFormState {
  const factory TransferFormState({
    @Default(RequestStatus.initial) RequestStatus status,
    int? selectedAccountIndex,
    @Default(TransactionType.cardNumber) TransactionType transactionType,
    int? selectedBeneficiaryIndex,
    @Default(false) bool saveToDirectory,
    String? errorMessage,
  }) = _TransferFormState;
}
