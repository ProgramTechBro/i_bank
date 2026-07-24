import '../../../../core/enums/message_icon_type.dart';

class MessageEntity {
  final String id;
  final String title;
  final String preview;
  final String timeLabel;
  final MessageIconType iconType;
  final bool hasThread;

  const MessageEntity({
    required this.id,
    required this.title,
    required this.preview,
    required this.timeLabel,
    required this.iconType,
    required this.hasThread,
  });
}
