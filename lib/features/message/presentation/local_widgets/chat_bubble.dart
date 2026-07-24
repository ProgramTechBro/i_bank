import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessageEntity message;

  static final _highlightPattern = RegExp(r'\d{5,}');

  List<TextSpan> _buildSpans(TextStyle? baseStyle, Color highlightColor) {
    final spans = <TextSpan>[];
    var start = 0;
    for (final match in _highlightPattern.allMatches(message.text)) {
      if (match.start > start) {
        spans.add(
          TextSpan(text: message.text.substring(start, match.start)),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: baseStyle?.copyWith(color: highlightColor),
        ),
      );
      start = match.end;
    }
    if (start < message.text.length) {
      spans.add(TextSpan(text: message.text.substring(start)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseStyle = textTheme.labelLarge?.copyWith(
      color: message.isSent ? AppColors.white : AppColors.neutral900,
    );

    return Align(
      alignment: message.isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 270),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: message.isSent ? AppColors.primary : AppColors.primaryTint,
            borderRadius: BorderRadius.circular(15),
          ),
          child: RichText(
            text: TextSpan(
              style: baseStyle,
              children: _buildSpans(baseStyle, AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}
