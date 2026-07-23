import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/managed_save_entity.dart';
import '../../domain/usecases/get_managed_saves_usecase.dart';

part 'managed_saves_provider.g.dart';

@riverpod
Future<List<ManagedSaveEntity>> managedSaves(Ref ref) async {
  final useCase = getIt<GetManagedSavesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (saves) => saves);
}
