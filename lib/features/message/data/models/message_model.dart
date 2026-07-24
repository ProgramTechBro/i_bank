import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.title,
    required super.preview,
    required super.timeLabel,
    required super.iconType,
    required super.hasThread,
  });
}
