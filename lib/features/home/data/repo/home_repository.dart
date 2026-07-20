import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/home_dashboard_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDashboardEntity>> getDashboard();
}
