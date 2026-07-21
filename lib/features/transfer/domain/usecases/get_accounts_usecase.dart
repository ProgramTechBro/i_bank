import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/transfer_repository.dart';
import '../entities/account_entity.dart';

@injectable
class GetAccountsUseCase {
  final TransferRepository repository;
  const GetAccountsUseCase(this.repository);

  Future<Either<Failure, List<AccountEntity>>> call() =>
      repository.getAccounts();
}
