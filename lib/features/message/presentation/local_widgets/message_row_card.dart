import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/extensions/message_icon_type_extension.dart';
import '../../domain/entities/message_entity.dart';

class MessageRowCard extends StatelessWidget {
  const MessageRowCard({super.key, required this.message, this.onTap});

  final MessageEntity message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: message.iconType.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  message.iconType.iconAsset,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.title, style: textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    message.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              message.timeLabel,
              style: textTheme.bodySmall?.copyWith(color: AppColors.neutral500),
            ),
          ],
        ),
      ),
    );
  }
}
