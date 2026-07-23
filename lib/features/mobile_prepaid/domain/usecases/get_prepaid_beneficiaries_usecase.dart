import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/mobile_prepaid_repository.dart';
import '../entities/prepaid_beneficiary_entity.dart';

@injectable
class GetPrepaidBeneficiariesUseCase {
  final MobilePrepaidRepository repository;
  const GetPrepaidBeneficiariesUseCase(this.repository);

  Future<Either<Failure, List<PrepaidBeneficiaryEntity>>> call() =>
      repository.getBeneficiaries();
}
