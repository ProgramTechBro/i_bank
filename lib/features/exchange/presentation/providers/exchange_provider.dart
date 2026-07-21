import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/currency_entity.dart';
import 'currencies_provider.dart';
import 'exchange_state.dart';

part 'exchange_provider.g.dart';

@riverpod
class ExchangeNotifier extends _$ExchangeNotifier {
  @override
  ExchangeState build() => const ExchangeState();

  void selectFromCurrency(String code) =>
      state = state.copyWith(fromCurrencyCode: code, toAmount: '');

  void selectToCurrency(String code) =>
      state = state.copyWith(toCurrencyCode: code, toAmount: '');

  void swap() {
    state = state.copyWith(
      fromCurrencyCode: state.toCurrencyCode,
      toCurrencyCode: state.fromCurrencyCode,
      toAmount: '',
    );
  }

  void exchange(String fromAmountText, List<CurrencyEntity> currencies) {
    final fromAmount = double.tryParse(fromAmountText);
    if (fromAmount == null) return;

    final from = findCurrency(currencies, state.fromCurrencyCode);
    final to = findCurrency(currencies, state.toCurrencyCode);
    if (from == null || to == null) return;

    final converted = fromAmount / from.rateToUsd * to.rateToUsd;
    state = state.copyWith(toAmount: converted.toStringAsFixed(2));
  }
}

CurrencyEntity? findCurrency(List<CurrencyEntity> currencies, String code) {
  for (final currency in currencies) {
    if (currency.code == code) return currency;
  }
  return null;
}

@riverpod
String exchangeRateLabel(Ref ref) {
  final exchangeState = ref.watch(exchangeNotifierProvider);
  final currenciesAsync = ref.watch(currenciesProvider);

  return currenciesAsync.maybeWhen(
    data: (currencies) {
      final from = findCurrency(currencies, exchangeState.fromCurrencyCode);
      final to = findCurrency(currencies, exchangeState.toCurrencyCode);
      if (from == null || to == null) return '';

      final rate = to.rateToUsd / from.rateToUsd;
      return '1 ${from.code} = ${rate.toStringAsFixed(2)} ${to.code}';
    },
    orElse: () => '',
  );
}
