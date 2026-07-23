import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'prepaid_form_state.dart';

part 'prepaid_form_provider.g.dart';

@riverpod
class PrepaidFormNotifier extends _$PrepaidFormNotifier {
  @override
  PrepaidFormState build() => const PrepaidFormState();

  void selectAccount(int index) =>
      state = state.copyWith(selectedAccountIndex: index);

  void selectBeneficiary(int index) => state = state.copyWith(
    selectedBeneficiaryIndex: index == state.selectedBeneficiaryIndex
        ? null
        : index,
  );

  void selectAmount(double amount) =>
      state = state.copyWith(selectedAmount: amount);
}
