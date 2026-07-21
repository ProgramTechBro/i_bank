import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_state.freezed.dart';

@freezed
class ExchangeState with _$ExchangeState {
  const factory ExchangeState({
    @Default('USD') String fromCurrencyCode,
    @Default('VND') String toCurrencyCode,
    @Default('') String toAmount,
  }) = _ExchangeState;
}
