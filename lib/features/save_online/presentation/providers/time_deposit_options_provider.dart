import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/time_deposit_option_entity.dart';
import '../../domain/usecases/get_time_deposit_options_usecase.dart';

part 'time_deposit_options_provider.g.dart';

@riverpod
Future<List<TimeDepositOptionEntity>> timeDepositOptions(Ref ref) async {
  final useCase = getIt<GetTimeDepositOptionsUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (options) => options);
}
