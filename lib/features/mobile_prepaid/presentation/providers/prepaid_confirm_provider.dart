import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/prepaid_recharge_entity.dart';
import '../../domain/usecases/submit_prepaid_recharge_usecase.dart';
import 'prepaid_confirm_state.dart';

part 'prepaid_confirm_provider.g.dart';

@riverpod
class PrepaidConfirmNotifier extends _$PrepaidConfirmNotifier {
  late final SubmitPrepaidRechargeUseCase _submitRecharge =
      getIt<SubmitPrepaidRechargeUseCase>();

  @override
  PrepaidConfirmState build(PrepaidRechargeEntity recharge) {
    _autoFillOtp();
    return const PrepaidConfirmState();
  }

  Future<void> _autoFillOtp() async {
    await Future.delayed(const Duration(milliseconds: 900));
    state = state.copyWith(otp: '6789');
  }

  void confirmOtp() {
    if (state.otp.isEmpty) return;
    state = state.copyWith(step: PrepaidConfirmStep.fingerprint);
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

  Future<void> confirmFingerprint() async {
    if (!state.fingerprintVerified) return;
    await _submitRecharge(recharge);
    state = state.copyWith(isSubmitted: true);
  }
}
