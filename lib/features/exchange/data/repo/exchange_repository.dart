import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/currency_entity.dart';

abstract class ExchangeRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();
}
