import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/pay_bill_repository.dart';
import '../entities/payment_history_entry_entity.dart';

@injectable
class GetPaymentHistoryUseCase {
  final PayBillRepository repository;
  const GetPaymentHistoryUseCase(this.repository);

  Future<Either<Failure, List<PaymentHistoryEntryEntity>>> call(
    BillCategory category,
  ) => repository.getPaymentHistory(category);
}
