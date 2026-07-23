import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/save_online_card_entity.dart';
import '../../domain/usecases/get_save_online_cards_usecase.dart';

part 'save_online_cards_provider.g.dart';

@riverpod
Future<List<SaveOnlineCardEntity>> saveOnlineCards(Ref ref) async {
  final useCase = getIt<GetSaveOnlineCardsUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (cards) => cards);
}
