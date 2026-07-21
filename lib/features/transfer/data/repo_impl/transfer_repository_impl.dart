import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/transfer_entity.dart';
import '../datasources/local/transfer_local_datasource.dart';
import '../repo/transfer_repository.dart';

@LazySingleton(as: TransferRepository)
class TransferRepositoryImpl implements TransferRepository {
  final TransferLocalDatasource localDatasource;
  const TransferRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries() async {
    try {
      final beneficiaries = await localDatasource.getBeneficiaries();
      return Right(beneficiaries);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AccountEntity>>> getAccounts() async {
    try {
      final accounts = await localDatasource.getAccounts();
      return Right(accounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendTransfer(TransferEntity transfer) async {
    try {
      await localDatasource.sendTransfer(transfer);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
