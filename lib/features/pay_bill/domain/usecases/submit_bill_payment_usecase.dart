import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/pay_bill_repository.dart';

@injectable
class SubmitBillPaymentUseCase {
  final PayBillRepository repository;
  const SubmitBillPaymentUseCase(this.repository);

  Future<Either<Failure, Unit>> call() => repository.submitPayment();
}
