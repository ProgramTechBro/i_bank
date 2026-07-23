import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bill_details_entity.dart';

part 'bill_pay_state.freezed.dart';

@freezed
class BillPayState with _$BillPayState {
  const factory BillPayState({
    BillDetailsEntity? billDetails,
    String? selectedAccountNumber,
    @Default('') String otp,
    @Default(false) bool isSubmitting,
  }) = _BillPayState;
}
