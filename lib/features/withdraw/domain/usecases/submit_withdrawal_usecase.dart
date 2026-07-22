import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/withdraw_repository.dart';
import '../entities/withdraw_entity.dart';

@injectable
class SubmitWithdrawalUseCase {
  final WithdrawRepository repository;
  const SubmitWithdrawalUseCase(this.repository);

  Future<Either<Failure, Unit>> call(WithdrawEntity withdrawal) =>
      repository.submitWithdrawal(withdrawal);
}
