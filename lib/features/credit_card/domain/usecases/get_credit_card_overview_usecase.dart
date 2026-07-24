import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/credit_card_repository.dart';
import '../entities/credit_card_overview_entity.dart';

@injectable
class GetCreditCardOverviewUseCase {
  final CreditCardRepository repository;
  const GetCreditCardOverviewUseCase(this.repository);

  Future<Either<Failure, CreditCardOverviewEntity>> call() =>
      repository.getOverview();
}
