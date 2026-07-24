import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chat_message_entity.dart';

part 'chat_thread_state.freezed.dart';

@freezed
class ChatThreadState with _$ChatThreadState {
  const factory ChatThreadState({
    @Default([]) List<ChatMessageEntity> messages,
    @Default(false) bool isSending,
  }) = _ChatThreadState;
}
