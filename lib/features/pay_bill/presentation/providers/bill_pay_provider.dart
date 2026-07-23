import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/bill_category.dart';
import '../../domain/usecases/get_bill_details_usecase.dart';
import '../../domain/usecases/submit_bill_payment_usecase.dart';
import 'bill_pay_state.dart';

part 'bill_pay_provider.g.dart';

@riverpod
class BillPayNotifier extends _$BillPayNotifier {
  late final GetBillDetailsUseCase _getBillDetails =
      getIt<GetBillDetailsUseCase>();
  late final SubmitBillPaymentUseCase _submitPayment =
      getIt<SubmitBillPaymentUseCase>();

  @override
  BillPayState build(BillCategory category, String companyName, String billCode) {
    _loadBillDetails();
    return const BillPayState();
  }

  Future<void> _loadBillDetails() async {
    final result = await _getBillDetails(
      category: category,
      companyName: companyName,
      billCode: billCode,
    );
    result.fold((failure) {}, (details) {
      state = state.copyWith(billDetails: details);
      _autoFill();
    });
  }

  Future<void> _autoFill() async {
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(
      selectedAccountNumber: '4411 0000 1234',
      otp: '23798',
    );
  }

  Future<bool> submit() async {
    state = state.copyWith(isSubmitting: true);
    final result = await _submitPayment();
    state = state.copyWith(isSubmitting: false);
    return result.isRight();
  }
}
