import 'dart:ui';
import 'package:flutter/material.dart';

class GlassWrap extends StatelessWidget {
  final Widget child;
  final bool isGlassMode;
  final double blur;
  final double connectivity;
  final BorderRadius? borderRadius;
  final bool isCircle;

  const GlassWrap({
    super.key,
    required this.child,
    this.isGlassMode = false,
    this.blur = 10,
    this.connectivity = 0.1,
    this.borderRadius,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isGlassMode) return child;

    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(1000)
          : (borderRadius ?? BorderRadius.circular(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: connectivity),
            borderRadius: isCircle
                ? BorderRadius.circular(1000)
                : (borderRadius ?? BorderRadius.circular(12)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
