import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/transaction_report_entity.dart';

abstract class TransactionReportRepository {
  Future<Either<Failure, TransactionReportEntity>> getTransactionReport();
}
