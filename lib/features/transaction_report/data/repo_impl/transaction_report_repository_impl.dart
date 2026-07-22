import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/transaction_report_entity.dart';
import '../datasources/local/transaction_report_local_datasource.dart';
import '../repo/transaction_report_repository.dart';

@LazySingleton(as: TransactionReportRepository)
class TransactionReportRepositoryImpl implements TransactionReportRepository {
  final TransactionReportLocalDatasource localDatasource;
  const TransactionReportRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, TransactionReportEntity>>
  getTransactionReport() async {
    try {
      final report = await localDatasource.getTransactionReport();
      return Right(report);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
