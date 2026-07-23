import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/mobile_prepaid_repository.dart';
import '../entities/prepaid_account_entity.dart';

@injectable
class GetPrepaidAccountsUseCase {
  final MobilePrepaidRepository repository;
  const GetPrepaidAccountsUseCase(this.repository);

  Future<Either<Failure, List<PrepaidAccountEntity>>> call() =>
      repository.getAccounts();
}
