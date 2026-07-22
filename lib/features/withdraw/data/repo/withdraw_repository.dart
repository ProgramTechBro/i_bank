import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/withdraw_account_entity.dart';
import '../../domain/entities/withdraw_entity.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, List<WithdrawAccountEntity>>> getAccounts();

  Future<Either<Failure, Unit>> submitWithdrawal(WithdrawEntity withdrawal);
}
