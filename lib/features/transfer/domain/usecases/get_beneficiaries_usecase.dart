import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/beneficiary_entity.dart';
import '../../data/repo/transfer_repository.dart';

@injectable
class GetBeneficiariesUseCase {
  final TransferRepository repository;
  const GetBeneficiariesUseCase(this.repository);

  Future<Either<Failure, List<BeneficiaryEntity>>> call() =>
      repository.getBeneficiaries();
}
