import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../datasources/local/beneficiary_local_datasource.dart';
import '../repo/beneficiary_repository.dart';

@LazySingleton(as: BeneficiaryRepository)
class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  final BeneficiaryLocalDatasource localDatasource;
  const BeneficiaryRepositoryImpl(this.localDatasource);

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
  Future<Either<Failure, Unit>> addBeneficiary(
    BeneficiaryEntity beneficiary,
  ) async {
    try {
      await localDatasource.addBeneficiary(beneficiary);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
