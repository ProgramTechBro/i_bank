import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/currency_entity.dart';
import '../datasources/local/exchange_local_datasource.dart';
import '../repo/exchange_repository.dart';

@LazySingleton(as: ExchangeRepository)
class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeLocalDatasource localDatasource;
  const ExchangeRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() async {
    try {
      final currencies = await localDatasource.getCurrencies();
      return Right(currencies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
