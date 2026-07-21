import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/send_reset_code_usecase.dart';
import '../../domain/usecases/verify_reset_code_usecase.dart';
import 'forgot_password_state.dart';

part 'forgot_password_provider.g.dart';

@riverpod
class ForgotPasswordNotifier extends _$ForgotPasswordNotifier {
  late final SendResetCodeUseCase _sendResetCode =
      getIt<SendResetCodeUseCase>();
  late final VerifyResetCodeUseCase _verifyResetCode =
      getIt<VerifyResetCodeUseCase>();

  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  void validatePhone(String phone) {
    state = state.copyWith(isPhoneValid: phone.trim().isNotEmpty);
  }

  void validateCode(String code) {
    state = state.copyWith(isCodeValid: code.trim().isNotEmpty);
  }

  void backToPhoneStep() {
    state = state.copyWith(step: ForgotPasswordStep.phone, isCodeValid: false);
  }

  Future<bool> sendCode(String phone) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _sendResetCode(phone: phone);
    return result.fold(
      (failure) {
        state = state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          status: RequestStatus.success,
          step: ForgotPasswordStep.code,
          phone: phone,
        );
        return true;
      },
    );
  }

  Future<bool> resendCode() => sendCode(state.phone);

  Future<bool> verifyCode(String code) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _verifyResetCode(code: code);
    return result.fold(
      (failure) {
        state = state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(status: RequestStatus.success);
        return true;
      },
    );
  }
}
