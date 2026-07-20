import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

part 'change_password_provider.g.dart';

@riverpod
class ChangePasswordNotifier extends _$ChangePasswordNotifier {
  late final ChangePasswordUseCase _changePassword =
      getIt<ChangePasswordUseCase>();

  @override
  ChangePasswordState build() => const ChangePasswordState();

  void toggleObscureNewPassword() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  void validate({required String newPassword, required String confirmPassword}) {
    state = state.copyWith(
      isFormValid:
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          newPassword == confirmPassword,
    );
  }

  Future<bool> submit(String newPassword) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _changePassword(newPassword: newPassword);
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
