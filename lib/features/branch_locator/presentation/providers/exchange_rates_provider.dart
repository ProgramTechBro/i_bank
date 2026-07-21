import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/usecases/get_exchange_rates_usecase.dart';

part 'exchange_rates_provider.g.dart';

@riverpod
Future<List<ExchangeRateEntity>> exchangeRates(Ref ref) async {
  final useCase = getIt<GetExchangeRatesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (rates) => rates);
}
