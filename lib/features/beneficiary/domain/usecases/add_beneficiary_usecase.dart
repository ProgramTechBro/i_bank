import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/beneficiary_repository.dart';
import '../entities/beneficiary_entity.dart';

@injectable
class AddBeneficiaryUseCase {
  final BeneficiaryRepository repository;
  const AddBeneficiaryUseCase(this.repository);

  Future<Either<Failure, Unit>> call(BeneficiaryEntity beneficiary) =>
      repository.addBeneficiary(beneficiary);
}
