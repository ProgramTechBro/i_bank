import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/mobile_prepaid_repository.dart';
import '../entities/prepaid_recharge_entity.dart';

@injectable
class SubmitPrepaidRechargeUseCase {
  final MobilePrepaidRepository repository;
  const SubmitPrepaidRechargeUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PrepaidRechargeEntity recharge) =>
      repository.submitRecharge(recharge);
}
