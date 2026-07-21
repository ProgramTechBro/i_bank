import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/usecases/send_transfer_usecase.dart';
import 'transfer_confirm_state.dart';

part 'transfer_confirm_provider.g.dart';

@riverpod
class TransferConfirmNotifier extends _$TransferConfirmNotifier {
  late final SendTransferUseCase _sendTransfer = getIt<SendTransferUseCase>();

  @override
  TransferConfirmState build(TransferEntity transfer) {
    _autoFillOtp();
    return const TransferConfirmState();
  }

  Future<void> _autoFillOtp() async {
    await Future.delayed(const Duration(milliseconds: 900));
    state = state.copyWith(otp: '6789');
  }

  void confirmOtp() {
    if (state.otp.isEmpty) return;
    state = state.copyWith(step: ConfirmStep.fingerprint);
  }

  void startFingerprintScan() {
    state = state.copyWith(isScanningFingerprint: true);
  }

  Future<void> verifyFingerprint() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    state = state.copyWith(
      isScanningFingerprint: false,
      fingerprintVerified: true,
    );
  }

  void confirmFingerprint() {
    if (!state.fingerprintVerified) return;
    state = state.copyWith(step: ConfirmStep.faceId);
    _autoMatchFace();
  }

  Future<void> _autoMatchFace() async {
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(faceMatched: true);
    await _sendTransfer(transfer);
  }
}
