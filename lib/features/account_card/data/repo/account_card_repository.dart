import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/account_card_report_entity.dart';

abstract class AccountCardRepository {
  Future<Either<Failure, AccountCardReportEntity>> getAccountCardReport();
}
