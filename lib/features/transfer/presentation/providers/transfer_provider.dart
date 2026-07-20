import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/get_beneficiaries_usecase.dart';
import '../../domain/usecases/send_transfer_usecase.dart';
import 'transfer_state.dart';

part 'transfer_provider.g.dart';

@riverpod
class TransferNotifier extends _$TransferNotifier {
  late final GetBeneficiariesUseCase _getBeneficiaries =
      getIt<GetBeneficiariesUseCase>();
  late final SendTransferUseCase _sendTransfer = getIt<SendTransferUseCase>();

  @override
  TransferState build() => const TransferState();

  Future<void> loadBeneficiaries() async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _getBeneficiaries();
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (beneficiaries) => state = state.copyWith(
        status: RequestStatus.success,
        beneficiaries: beneficiaries,
      ),
    );
  }

  Future<void> sendTransfer() async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _sendTransfer();
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: RequestStatus.success),
    );
  }
}
