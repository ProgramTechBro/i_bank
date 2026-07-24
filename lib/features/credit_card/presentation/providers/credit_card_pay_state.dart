import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_pay_state.freezed.dart';

@freezed
class CreditCardPayState with _$CreditCardPayState {
  const factory CreditCardPayState({
    int? selectedAccountIndex,
    @Default('') String otp,
    @Default(false) bool isRequestingOtp,
    @Default(false) bool isSubmitting,
  }) = _CreditCardPayState;
}
