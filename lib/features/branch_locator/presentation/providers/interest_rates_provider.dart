import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/interest_rate_entity.dart';
import '../../domain/usecases/get_interest_rates_usecase.dart';

part 'interest_rates_provider.g.dart';

@riverpod
Future<List<InterestRateEntity>> interestRates(Ref ref) async {
  final useCase = getIt<GetInterestRatesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (rates) => rates);
}
