import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/home_dashboard_entity.dart';
import '../datasources/local/home_local_datasource.dart';
import '../repo/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource localDatasource;
  const HomeRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, HomeDashboardEntity>> getDashboard() async {
    try {
      final dashboard = await localDatasource.getDashboard();
      return Right(dashboard);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
