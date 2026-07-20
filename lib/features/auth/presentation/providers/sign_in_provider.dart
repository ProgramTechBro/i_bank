import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import 'sign_in_state.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  late final SignInUseCase _signIn = getIt<SignInUseCase>();

  @override
  SignInState build() => const SignInState();

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void validate({required String identifier, required String password}) {
    state = state.copyWith(
      isFormValid: identifier.trim().isNotEmpty && password.trim().isNotEmpty,
    );
  }

  Future<bool> submit({
    required String identifier,
    required String password,
  }) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _signIn(identifier: identifier, password: password);
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
