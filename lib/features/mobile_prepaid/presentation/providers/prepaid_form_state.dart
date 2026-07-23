import 'package:freezed_annotation/freezed_annotation.dart';

part 'prepaid_form_state.freezed.dart';

@freezed
class PrepaidFormState with _$PrepaidFormState {
  const factory PrepaidFormState({
    int? selectedAccountIndex,
    int? selectedBeneficiaryIndex,
    double? selectedAmount,
  }) = _PrepaidFormState;
}
