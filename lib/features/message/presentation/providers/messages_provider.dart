import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/get_messages_usecase.dart';

part 'messages_provider.g.dart';

@riverpod
Future<List<MessageEntity>> messages(Ref ref) async {
  final useCase = getIt<GetMessagesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (messages) => messages);
}
