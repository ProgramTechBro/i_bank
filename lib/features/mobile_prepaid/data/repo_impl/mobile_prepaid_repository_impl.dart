import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/prepaid_account_entity.dart';
import '../../domain/entities/prepaid_beneficiary_entity.dart';
import '../../domain/entities/prepaid_recharge_entity.dart';
import '../datasources/local/mobile_prepaid_local_datasource.dart';
import '../repo/mobile_prepaid_repository.dart';

@LazySingleton(as: MobilePrepaidRepository)
class MobilePrepaidRepositoryImpl implements MobilePrepaidRepository {
  final MobilePrepaidLocalDatasource localDatasource;
  const MobilePrepaidRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<PrepaidBeneficiaryEntity>>>
  getBeneficiaries() async {
    try {
      final beneficiaries = await localDatasource.getBeneficiaries();
      return Right(beneficiaries);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PrepaidAccountEntity>>> getAccounts() async {
    try {
      final accounts = await localDatasource.getAccounts();
      return Right(accounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitRecharge(
    PrepaidRechargeEntity recharge,
  ) async {
    try {
      await localDatasource.submitRecharge(recharge);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
