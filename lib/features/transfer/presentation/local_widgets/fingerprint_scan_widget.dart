import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class FingerprintScanWidget extends StatefulWidget {
  const FingerprintScanWidget({
    super.key,
    required this.isScanning,
    required this.isVerified,
    required this.onTap,
  });

  final bool isScanning;
  final bool isVerified;
  final VoidCallback onTap;

  @override
  State<FingerprintScanWidget> createState() => _FingerprintScanWidgetState();
}

class _FingerprintScanWidgetState extends State<FingerprintScanWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isVerified
        ? AppColors.semanticSuccess
        : AppColors.primary;

    return GestureDetector(
      onTap: widget.isVerified ? null : widget.onTap,
      child: SizedBox(
        width: 100,
        height: 100,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) => CustomPaint(
            painter: _PulsePainter(
              progress: _pulseController.value,
              active: widget.isScanning,
              color: color,
            ),
            child: child,
          ),
          child: Center(
            child: AnimatedScale(
              scale: widget.isVerified ? 1.15 : 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              child: Icon(
                widget.isVerified ? Icons.check_circle : Icons.fingerprint,
                size: 64,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  const _PulsePainter({
    required this.progress,
    required this.active,
    required this.color,
  });

  final double progress;
  final bool active;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (!active) return;
    final center = size.center(Offset.zero);
    final maxRadius = size.width / 2;

    for (final offset in const [0.0, 0.5]) {
      final t = (progress + offset) % 1.0;
      final radius = maxRadius * t;
      final opacity = (1 - t).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = color.withValues(alpha: opacity * 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.active != active ||
      oldDelegate.color != color;
}
