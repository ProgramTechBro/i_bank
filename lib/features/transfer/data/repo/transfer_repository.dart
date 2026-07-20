import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/beneficiary_entity.dart';

abstract class TransferRepository {
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries();
  Future<Either<Failure, Unit>> sendTransfer();
}
