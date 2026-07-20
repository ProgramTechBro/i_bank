import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(false) bool obscurePassword,
    @Default(false) bool isFormValid,
    String? errorMessage,
  }) = _SignInState;
}
