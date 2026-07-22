import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_form_state.freezed.dart';

@freezed
class WithdrawFormState with _$WithdrawFormState {
  const factory WithdrawFormState({
    int? selectedAccountIndex,
    double? selectedAmount,
    @Default(false) bool isOtherSelected,
    @Default(false) bool isSubmitting,
  }) = _WithdrawFormState;
}
