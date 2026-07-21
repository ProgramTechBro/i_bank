import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/usecases/get_languages_usecase.dart';

part 'languages_provider.g.dart';

@riverpod
Future<List<LanguageEntity>> languages(Ref ref) async {
  final useCase = getIt<GetLanguagesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (languages) => languages);
}

@riverpod
class SelectedLanguageIndex extends _$SelectedLanguageIndex {
  @override
  int build() => 2;

  void select(int index) => state = index;
}
