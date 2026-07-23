import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/beneficiary_repository.dart';
import '../entities/beneficiary_entity.dart';

@injectable
class GetBeneficiariesUseCase {
  final BeneficiaryRepository repository;
  const GetBeneficiariesUseCase(this.repository);

  Future<Either<Failure, List<BeneficiaryEntity>>> call() =>
      repository.getBeneficiaries();
}
