import 'package:injectable/injectable.dart';
import '../../../domain/entities/currency_entity.dart';

abstract class ExchangeLocalDatasource {
  Future<List<CurrencyEntity>> getCurrencies();
}

@LazySingleton(as: ExchangeLocalDatasource)
class ExchangeLocalDatasourceImpl implements ExchangeLocalDatasource {
  @override
  Future<List<CurrencyEntity>> getCurrencies() async {
    return const [
      CurrencyEntity(
        code: 'VND',
        symbol: 'VND',
        name: 'Viet Nam Dong',
        rateToUsd: 24000,
      ),
      CurrencyEntity(
        code: 'HKD',
        symbol: 'HK\$',
        name: 'Hong Kong Dollar',
        rateToUsd: 7.8,
      ),
      CurrencyEntity(code: 'USD', symbol: 'USD', name: 'Dollar', rateToUsd: 1),
      CurrencyEntity(
        code: 'TWD',
        symbol: 'NT\$',
        name: 'Taiwan Dollar',
        rateToUsd: 31.5,
      ),
      CurrencyEntity(
        code: 'JMD',
        symbol: 'J\$',
        name: 'Jamaika Dollar',
        rateToUsd: 155.8,
      ),
    ];
  }
}
