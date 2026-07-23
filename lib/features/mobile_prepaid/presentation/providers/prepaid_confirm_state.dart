import 'package:freezed_annotation/freezed_annotation.dart';

part 'prepaid_confirm_state.freezed.dart';

enum PrepaidConfirmStep { otp, fingerprint }

@freezed
class PrepaidConfirmState with _$PrepaidConfirmState {
  const factory PrepaidConfirmState({
    @Default(PrepaidConfirmStep.otp) PrepaidConfirmStep step,
    @Default('') String otp,
    @Default(false) bool isScanningFingerprint,
    @Default(false) bool fingerprintVerified,
    @Default(false) bool isSubmitted,
  }) = _PrepaidConfirmState;
}
