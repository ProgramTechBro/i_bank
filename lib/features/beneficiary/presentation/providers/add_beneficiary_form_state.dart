import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/transaction_type.dart';

part 'add_beneficiary_form_state.freezed.dart';

@freezed
class AddBeneficiaryFormState with _$AddBeneficiaryFormState {
  const factory AddBeneficiaryFormState({
    @Default(TransactionType.cardNumber) TransactionType transferType,
    String? bank,
    String? branch,
    @Default(false) bool isSubmitting,
  }) = _AddBeneficiaryFormState;
}
