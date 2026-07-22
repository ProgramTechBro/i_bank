import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/account_card_repository.dart';
import '../entities/account_card_report_entity.dart';

@injectable
class GetAccountCardReportUseCase {
  final AccountCardRepository repository;
  const GetAccountCardReportUseCase(this.repository);

  Future<Either<Failure, AccountCardReportEntity>> call() =>
      repository.getAccountCardReport();
}
