import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/withdraw_repository.dart';
import '../entities/withdraw_account_entity.dart';

@injectable
class GetWithdrawAccountsUseCase {
  final WithdrawRepository repository;
  const GetWithdrawAccountsUseCase(this.repository);

  Future<Either<Failure, List<WithdrawAccountEntity>>> call() =>
      repository.getAccounts();
}
