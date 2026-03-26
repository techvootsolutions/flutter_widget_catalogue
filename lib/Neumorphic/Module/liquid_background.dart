import 'package:flutter/material.dart';
import 'dart:math' as math;

class LiquidBackground extends StatefulWidget {
  const LiquidBackground({super.key});

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _LiquidPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class _LiquidPainter extends CustomPainter {
  final double progress;

  _LiquidPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw background
    paint.color = const Color(0xFF0F172A); // Dark slate background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw animated blobs
    final center1 = Offset(
      size.width * (0.5 + 0.2 * math.sin(progress * 2 * math.pi)),
      size.height * (0.5 + 0.2 * math.cos(progress * 2 * math.pi)),
    );
    _drawBlob(canvas, center1, size.width * 0.4,
        const Color(0xFF3B82F6).withValues(alpha: 0.3));

    final center2 = Offset(
      size.width * (0.3 + 0.2 * math.cos(progress * 2 * math.pi + 1)),
      size.height * (0.7 + 0.2 * math.sin(progress * 2 * math.pi + 1)),
    );
    _drawBlob(canvas, center2, size.width * 0.5,
        const Color(0xFF8B5CF6).withValues(alpha: 0.3));

    final center3 = Offset(
      size.width * (0.7 + 0.2 * math.sin(progress * 2 * math.pi + 2)),
      size.height * (0.3 + 0.2 * math.cos(progress * 2 * math.pi + 2)),
    );
    _drawBlob(canvas, center3, size.width * 0.45,
        const Color(0xFFEC4899).withValues(alpha: 0.2));
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _LiquidPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
