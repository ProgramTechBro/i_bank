import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/credit_card_account_entity.dart';
import '../../domain/entities/credit_card_overview_entity.dart';

abstract class CreditCardRepository {
  Future<Either<Failure, CreditCardOverviewEntity>> getOverview();

  Future<Either<Failure, List<CreditCardAccountEntity>>> getAccounts();

  Future<Either<Failure, Unit>> submitPayment({
    required String accountNumber,
    required String otp,
  });
}
