import 'package:injectable/injectable.dart';
import '../../../domain/entities/branch_entity.dart';
import '../../../domain/entities/exchange_rate_entity.dart';
import '../../../domain/entities/interest_rate_entity.dart';

abstract class BranchLocatorLocalDatasource {
  Future<List<BranchEntity>> getBranches();

  Future<List<InterestRateEntity>> getInterestRates();

  Future<List<ExchangeRateEntity>> getExchangeRates();
}

@LazySingleton(as: BranchLocatorLocalDatasource)
class BranchLocatorLocalDatasourceImpl implements BranchLocatorLocalDatasource {
  @override
  Future<List<BranchEntity>> getBranches() async {
    return const [
      BranchEntity(name: 'Bank 1656 Union Street', distance: '50 m'),
      BranchEntity(name: 'Bank Secaucus', distance: '1,2 km'),
      BranchEntity(name: 'Bank 1657 Riverside Drive', distance: '5,3 km'),
      BranchEntity(name: 'Bank Rutherford', distance: '70m'),
      BranchEntity(name: 'Bank 1656 Union Street', distance: '30m'),
    ];
  }

  @override
  Future<List<InterestRateEntity>> getInterestRates() async {
    return const [
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Corporate customers',
        deposit: '2m',
        rate: '5.50%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Corporate customers',
        deposit: '6m',
        rate: '2.50%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Corporate customers',
        deposit: '8m',
        rate: '6.50%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Corporate customers',
        deposit: '7m',
        rate: '6.80%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '12m',
        rate: '5.90%',
      ),
      InterestRateEntity(
        customerType: 'Individual customers',
        deposit: '1m',
        rate: '4.50%',
      ),
    ];
  }

  @override
  Future<List<ExchangeRateEntity>> getExchangeRates() async {
    return const [
      ExchangeRateEntity(
        countryCode: 'VN',
        countryName: 'Vietnam',
        buy: '1.403',
        sell: '1.746',
      ),
      ExchangeRateEntity(
        countryCode: 'NI',
        countryName: 'Nicaragua',
        buy: '9.123',
        sell: '12.09',
      ),
      ExchangeRateEntity(
        countryCode: 'KR',
        countryName: 'Korea',
        buy: '3.704',
        sell: '5.151',
      ),
      ExchangeRateEntity(
        countryCode: 'RU',
        countryName: 'Russia',
        buy: '116.0',
        sell: '144.4',
      ),
      ExchangeRateEntity(
        countryCode: 'CN',
        countryName: 'China',
        buy: '1.725',
        sell: '2.234',
      ),
      ExchangeRateEntity(
        countryCode: 'PT',
        countryName: 'Portuguese',
        buy: '1.403',
        sell: '1.746',
      ),
      ExchangeRateEntity(
        countryCode: 'KR',
        countryName: 'Korea',
        buy: '3.454',
        sell: '4.312',
      ),
      ExchangeRateEntity(
        countryCode: 'FR',
        countryName: 'French',
        buy: '23.45',
        sell: '34.56',
      ),
      ExchangeRateEntity(
        countryCode: 'NI',
        countryName: 'Nicaragua',
        buy: '263.1',
        sell: '300.3',
      ),
      ExchangeRateEntity(
        countryCode: 'CN',
        countryName: 'China',
        buy: '1.725',
        sell: '2.234',
      ),
    ];
  }
}
