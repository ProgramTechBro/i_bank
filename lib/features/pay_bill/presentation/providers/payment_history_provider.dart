import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/bill_category.dart';
import '../../domain/entities/payment_history_entry_entity.dart';
import '../../domain/usecases/get_payment_history_usecase.dart';

part 'payment_history_provider.g.dart';

@riverpod
Future<List<PaymentHistoryEntryEntity>> paymentHistory(
  Ref ref,
  BillCategory category,
) async {
  final useCase = getIt<GetPaymentHistoryUseCase>();
  final result = await useCase(category);
  return result.fold((failure) => throw failure, (history) => history);
}
