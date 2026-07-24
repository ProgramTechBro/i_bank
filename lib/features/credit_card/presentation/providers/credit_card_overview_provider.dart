import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/credit_card_overview_entity.dart';
import '../../domain/usecases/get_credit_card_overview_usecase.dart';

part 'credit_card_overview_provider.g.dart';

@riverpod
Future<CreditCardOverviewEntity> creditCardOverview(Ref ref) async {
  final useCase = getIt<GetCreditCardOverviewUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (overview) => overview);
}
