import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/transfer_entity.dart';

abstract class TransferRepository {
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries();

  Future<Either<Failure, List<AccountEntity>>> getAccounts();

  Future<Either<Failure, Unit>> sendTransfer(TransferEntity transfer);
}
