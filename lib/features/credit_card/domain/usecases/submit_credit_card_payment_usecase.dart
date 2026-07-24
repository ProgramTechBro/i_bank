import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/credit_card_repository.dart';

@injectable
class SubmitCreditCardPaymentUseCase {
  final CreditCardRepository repository;
  const SubmitCreditCardPaymentUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String accountNumber,
    required String otp,
  }) => repository.submitPayment(accountNumber: accountNumber, otp: otp);
}
