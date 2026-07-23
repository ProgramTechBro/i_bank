import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_online_form_state.freezed.dart';

@freezed
class SaveOnlineFormState with _$SaveOnlineFormState {
  const factory SaveOnlineFormState({
    int? selectedCardIndex,
    int? selectedDepositIndex,
    @Default(false) bool isSubmitting,
  }) = _SaveOnlineFormState;
}
