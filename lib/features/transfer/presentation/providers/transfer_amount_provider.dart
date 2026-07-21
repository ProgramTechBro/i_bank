import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/helpers/formatters.dart';

part 'transfer_amount_provider.g.dart';

@riverpod
class TransferAmountText extends _$TransferAmountText {
  @override
  String build() => '';

  void update(String value) => state = value;
}

@riverpod
String transferAmountInWords(Ref ref) {
  final text = ref.watch(transferAmountTextProvider);
  final amount = int.tryParse(text);
  if (amount == null || amount <= 0) return '';
  return Formatters.amountToWords(amount);
}
