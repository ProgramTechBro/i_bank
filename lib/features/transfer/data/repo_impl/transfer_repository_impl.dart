import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../repo/transfer_repository.dart';

@LazySingleton(as: TransferRepository)
class TransferRepositoryImpl implements TransferRepository {
  @override
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries() async =>
      const Right([]);

  @override
  Future<Either<Failure, Unit>> sendTransfer() async => const Right(unit);
}
