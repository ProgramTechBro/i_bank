import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppAddNewCardButton extends StatelessWidget {
  const AppAddNewCardButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: CustomPaint(
          painter: const _DashedBorderPainter(
            color: AppColors.primaryDisabled,
            borderRadius: 15,
          ),
          child: Center(
            child: Text(
              'Add new card',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryDisabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.borderRadius});

  final Color color;
  final double borderRadius;

  static const double _dashWidth = 6;
  static const double _dashGap = 4;
  static const double _strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final metric = (Path()..addRRect(rrect)).computeMetrics().first;

    var distance = 0.0;
    while (distance < metric.length) {
      final next = distance + _dashWidth;
      canvas.drawPath(
        metric.extractPath(distance, next.clamp(0, metric.length)),
        paint,
      );
      distance = next + _dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.borderRadius != borderRadius;
}
