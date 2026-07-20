import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';

part 'forgot_password_state.freezed.dart';

enum ForgotPasswordStep { phone, code }

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(ForgotPasswordStep.phone) ForgotPasswordStep step,
    @Default(RequestStatus.initial) RequestStatus status,
    @Default('') String phone,
    @Default(false) bool isPhoneValid,
    @Default(false) bool isCodeValid,
    String? errorMessage,
  }) = _ForgotPasswordState;
}
