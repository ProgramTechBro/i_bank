import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/save_online_request_entity.dart';
import '../../domain/usecases/submit_save_online_usecase.dart';
import 'save_online_form_state.dart';

part 'save_online_form_provider.g.dart';

@riverpod
class SaveOnlineFormNotifier extends _$SaveOnlineFormNotifier {
  late final SubmitSaveOnlineUseCase _submitSaveOnline =
      getIt<SubmitSaveOnlineUseCase>();

  @override
  SaveOnlineFormState build() => const SaveOnlineFormState();

  void selectCard(int index) =>
      state = state.copyWith(selectedCardIndex: index);

  void selectDeposit(int index) =>
      state = state.copyWith(selectedDepositIndex: index);

  Future<bool> submit({
    required String accountLabel,
    required int depositMonths,
    required double interestRate,
    required double amount,
  }) async {
    state = state.copyWith(isSubmitting: true);
    final result = await _submitSaveOnline(
      SaveOnlineRequestEntity(
        accountLabel: accountLabel,
        depositMonths: depositMonths,
        interestRate: interestRate,
        amount: amount,
      ),
    );
    state = state.copyWith(isSubmitting: false);
    return result.isRight();
  }
}
