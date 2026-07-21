import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/exchange_repository.dart';
import '../entities/currency_entity.dart';

@injectable
class GetCurrenciesUseCase {
  final ExchangeRepository repository;
  const GetCurrenciesUseCase(this.repository);

  Future<Either<Failure, List<CurrencyEntity>>> call() =>
      repository.getCurrencies();
}
