import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(false) bool obscurePassword,
    @Default(false) bool agreedToTerms,
    @Default(false) bool isFormValid,
    String? errorMessage,
  }) = _SignUpState;
}
