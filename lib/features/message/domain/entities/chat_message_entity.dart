class ChatMessageEntity {
  final String text;
  final bool isSent;
  final String? dateLabel;

  const ChatMessageEntity({
    required this.text,
    required this.isSent,
    this.dateLabel,
  });
}
