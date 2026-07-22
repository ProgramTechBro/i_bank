import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/account_card_report_entity.dart';
import '../../domain/usecases/get_account_card_report_usecase.dart';

part 'account_card_report_provider.g.dart';

@riverpod
Future<AccountCardReportEntity> accountCardReport(Ref ref) async {
  final useCase = getIt<GetAccountCardReportUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (report) => report);
}
