import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/prepaid_account_entity.dart';
import '../../domain/entities/prepaid_beneficiary_entity.dart';
import '../../domain/entities/prepaid_recharge_entity.dart';

abstract class MobilePrepaidRepository {
  Future<Either<Failure, List<PrepaidBeneficiaryEntity>>> getBeneficiaries();

  Future<Either<Failure, List<PrepaidAccountEntity>>> getAccounts();

  Future<Either<Failure, Unit>> submitRecharge(PrepaidRechargeEntity recharge);
}
