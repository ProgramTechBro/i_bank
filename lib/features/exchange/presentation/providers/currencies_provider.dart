import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/usecases/get_currencies_usecase.dart';

part 'currencies_provider.g.dart';

@riverpod
Future<List<CurrencyEntity>> currencies(Ref ref) async {
  final useCase = getIt<GetCurrenciesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (currencies) => currencies);
}
