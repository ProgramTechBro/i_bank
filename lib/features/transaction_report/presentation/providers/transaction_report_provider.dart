import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/transaction_report_entity.dart';
import '../../domain/usecases/get_transaction_report_usecase.dart';

part 'transaction_report_provider.g.dart';

@riverpod
Future<TransactionReportEntity> transactionReport(Ref ref) async {
  final useCase = getIt<GetTransactionReportUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (report) => report);
}
