import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(false) bool obscureNewPassword,
    @Default(false) bool obscureConfirmPassword,
    @Default(false) bool isFormValid,
    String? errorMessage,
  }) = _ChangePasswordState;
}
