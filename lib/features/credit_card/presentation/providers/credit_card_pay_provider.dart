import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/usecases/submit_credit_card_payment_usecase.dart';
import 'credit_card_pay_state.dart';

part 'credit_card_pay_provider.g.dart';

@riverpod
class CreditCardPayNotifier extends _$CreditCardPayNotifier {
  late final SubmitCreditCardPaymentUseCase _submitPayment =
      getIt<SubmitCreditCardPaymentUseCase>();

  @override
  CreditCardPayState build() => const CreditCardPayState();

  void selectAccount(int index) =>
      state = state.copyWith(selectedAccountIndex: index, otp: '');

  Future<void> requestOtp() async {
    state = state.copyWith(isRequestingOtp: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isRequestingOtp: false, otp: '23798');
  }

  Future<bool> submit(String accountNumber) async {
    state = state.copyWith(isSubmitting: true);
    final result = await _submitPayment(
      accountNumber: accountNumber,
      otp: state.otp,
    );
    state = state.copyWith(isSubmitting: false);
    return result.isRight();
  }
}
