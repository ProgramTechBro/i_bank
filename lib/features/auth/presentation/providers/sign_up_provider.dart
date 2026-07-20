import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_state.dart';

part 'sign_up_provider.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  late final SignUpUseCase _signUp = getIt<SignUpUseCase>();

  @override
  SignUpState build() => const SignUpState();

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleAgreedToTerms() {
    state = state.copyWith(agreedToTerms: !state.agreedToTerms);
  }

  void validate({
    required String name,
    required String phone,
    required String password,
  }) {
    state = state.copyWith(
      isFormValid:
          name.trim().isNotEmpty &&
          phone.trim().isNotEmpty &&
          password.trim().isNotEmpty &&
          state.agreedToTerms,
    );
  }

  Future<bool> submit({
    required String name,
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _signUp(name: name, phone: phone, password: password);
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
