import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/usecases/get_thread_messages_usecase.dart';
import '../../domain/usecases/send_thread_message_usecase.dart';
import 'chat_thread_state.dart';

part 'chat_thread_provider.g.dart';

@riverpod
class ChatThreadNotifier extends _$ChatThreadNotifier {
  late final GetThreadMessagesUseCase _getThreadMessages =
      getIt<GetThreadMessagesUseCase>();
  late final SendThreadMessageUseCase _sendThreadMessage =
      getIt<SendThreadMessageUseCase>();

  @override
  ChatThreadState build() {
    _load();
    return const ChatThreadState();
  }

  Future<void> _load() async {
    final result = await _getThreadMessages();
    result.fold((failure) {}, (messages) {
      state = state.copyWith(messages: messages);
    });
  }

  Future<void> sendMessage(String text) async {
    state = state.copyWith(isSending: true);
    final result = await _sendThreadMessage(text);
    result.fold((failure) {}, (message) {
      state = state.copyWith(messages: [...state.messages, message]);
    });
    state = state.copyWith(isSending: false);
  }
}
