import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/account_card_report_entity.dart';
import '../datasources/local/account_card_local_datasource.dart';
import '../repo/account_card_repository.dart';

@LazySingleton(as: AccountCardRepository)
class AccountCardRepositoryImpl implements AccountCardRepository {
  final AccountCardLocalDatasource localDatasource;
  const AccountCardRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, AccountCardReportEntity>>
  getAccountCardReport() async {
    try {
      final report = await localDatasource.getAccountCardReport();
      return Right(report);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
