import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/home_repository.dart';
import '../entities/home_dashboard_entity.dart';

@injectable
class GetHomeDashboardUseCase {
  final HomeRepository repository;
  const GetHomeDashboardUseCase(this.repository);

  Future<Either<Failure, HomeDashboardEntity>> call() =>
      repository.getDashboard();
}
