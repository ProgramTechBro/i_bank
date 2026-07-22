import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/withdraw_entity.dart';
import '../../domain/usecases/submit_withdrawal_usecase.dart';
import 'withdraw_form_state.dart';

part 'withdraw_form_provider.g.dart';

@riverpod
class WithdrawFormNotifier extends _$WithdrawFormNotifier {
  late final SubmitWithdrawalUseCase _submitWithdrawal =
      getIt<SubmitWithdrawalUseCase>();

  @override
  WithdrawFormState build() => const WithdrawFormState();

  void selectAccount(int index) =>
      state = state.copyWith(selectedAccountIndex: index);

  void selectAmount(double amount) =>
      state = state.copyWith(selectedAmount: amount, isOtherSelected: false);

  void selectOther() =>
      state = state.copyWith(selectedAmount: null, isOtherSelected: true);

  Future<bool> submit({
    required String accountNumber,
    required String phoneNumber,
    required double amount,
  }) async {
    state = state.copyWith(isSubmitting: true);
    final result = await _submitWithdrawal(
      WithdrawEntity(
        accountNumber: accountNumber,
        phoneNumber: phoneNumber,
        amount: amount,
      ),
    );
    state = state.copyWith(isSubmitting: false);
    return result.isRight();
  }
}
