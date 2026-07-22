import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/transaction_report_repository.dart';
import '../entities/transaction_report_entity.dart';

@injectable
class GetTransactionReportUseCase {
  final TransactionReportRepository repository;
  const GetTransactionReportUseCase(this.repository);

  Future<Either<Failure, TransactionReportEntity>> call() =>
      repository.getTransactionReport();
}
