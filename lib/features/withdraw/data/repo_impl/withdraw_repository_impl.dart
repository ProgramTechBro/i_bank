import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/withdraw_account_entity.dart';
import '../../domain/entities/withdraw_entity.dart';
import '../datasources/local/withdraw_local_datasource.dart';
import '../repo/withdraw_repository.dart';

@LazySingleton(as: WithdrawRepository)
class WithdrawRepositoryImpl implements WithdrawRepository {
  final WithdrawLocalDatasource localDatasource;
  const WithdrawRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<WithdrawAccountEntity>>> getAccounts() async {
    try {
      final accounts = await localDatasource.getAccounts();
      return Right(accounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitWithdrawal(
    WithdrawEntity withdrawal,
  ) async {
    try {
      await localDatasource.submitWithdrawal(withdrawal);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
