import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/beneficiary_entity.dart';

part 'transfer_state.freezed.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(<BeneficiaryEntity>[]) List<BeneficiaryEntity> beneficiaries,
    String? errorMessage,
  }) = _TransferState;
}
