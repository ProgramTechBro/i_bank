import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/credit_card_repository.dart';
import '../entities/credit_card_account_entity.dart';

@injectable
class GetCreditCardAccountsUseCase {
  final CreditCardRepository repository;
  const GetCreditCardAccountsUseCase(this.repository);

  Future<Either<Failure, List<CreditCardAccountEntity>>> call() =>
      repository.getAccounts();
}
