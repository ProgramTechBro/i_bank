import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_confirm_state.freezed.dart';

enum ConfirmStep { otp, fingerprint, faceId }

@freezed
class TransferConfirmState with _$TransferConfirmState {
  const factory TransferConfirmState({
    @Default(ConfirmStep.otp) ConfirmStep step,
    @Default('') String otp,
    @Default(false) bool isScanningFingerprint,
    @Default(false) bool fingerprintVerified,
    @Default(false) bool faceMatched,
  }) = _TransferConfirmState;
}
