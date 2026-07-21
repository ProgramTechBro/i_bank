import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/branch_locator_repository.dart';
import '../entities/branch_entity.dart';

@injectable
class GetBranchesUseCase {
  final BranchLocatorRepository repository;
  const GetBranchesUseCase(this.repository);

  Future<Either<Failure, List<BranchEntity>>> call() =>
      repository.getBranches();
}
