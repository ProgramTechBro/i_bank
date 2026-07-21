import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class FaceIdScanWidget extends StatefulWidget {
  const FaceIdScanWidget({super.key, required this.isMatched});

  final bool isMatched;

  @override
  State<FaceIdScanWidget> createState() => _FaceIdScanWidgetState();
}

class _FaceIdScanWidgetState extends State<FaceIdScanWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scanController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isMatched
        ? AppColors.semanticSuccess
        : AppColors.primary;

    return SizedBox(
      width: 100,
      height: 100,
      child: AnimatedBuilder(
        animation: _scanController,
        builder: (context, child) => CustomPaint(
          painter: _FaceIdFramePainter(
            scanPosition: widget.isMatched ? null : _scanController.value,
            color: color,
          ),
          child: child,
        ),
        child: Center(
          child: AnimatedScale(
            scale: widget.isMatched ? 1.15 : 1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
            child: Icon(
              widget.isMatched ? Icons.check_circle : Icons.face_outlined,
              size: 48,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _FaceIdFramePainter extends CustomPainter {
  const _FaceIdFramePainter({required this.scanPosition, required this.color});

  final double? scanPosition;
  final Color color;

  static const _cornerLength = 16.0;
  static const _inset = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final cornerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    void drawCorner(Offset start, Offset horizontal, Offset vertical) {
      canvas.drawLine(start, start + horizontal, cornerPaint);
      canvas.drawLine(start, start + vertical, cornerPaint);
    }

    drawCorner(
      const Offset(_inset, _inset),
      const Offset(_cornerLength, 0),
      const Offset(0, _cornerLength),
    );
    drawCorner(
      Offset(size.width - _inset, _inset),
      const Offset(-_cornerLength, 0),
      const Offset(0, _cornerLength),
    );
    drawCorner(
      Offset(_inset, size.height - _inset),
      const Offset(_cornerLength, 0),
      const Offset(0, -_cornerLength),
    );
    drawCorner(
      Offset(size.width - _inset, size.height - _inset),
      const Offset(-_cornerLength, 0),
      const Offset(0, -_cornerLength),
    );

    if (scanPosition != null) {
      final y = _inset + (size.height - _inset * 2) * scanPosition!;
      final linePaint = Paint()
        ..color = color.withValues(alpha: 0.6)
        ..strokeWidth = 2;
      canvas.drawLine(
        Offset(_inset + 6, y),
        Offset(size.width - _inset - 6, y),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FaceIdFramePainter oldDelegate) =>
      oldDelegate.scanPosition != scanPosition || oldDelegate.color != color;
}
