import 'package:flutter/material.dart' show Colors;
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

@immutable
class NeumorphicIcon extends StatelessWidget {
  final IconData icon;
  final NeumorphicStyle? style;
  final Curve curve;
  final double size;
  final Duration duration;
  final bool isGlassMode;

  const NeumorphicIcon(
    this.icon, {
    super.key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.size = 20,
    this.isGlassMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassWrap(
      isGlassMode: isGlassMode,
      isCircle: style?.boxShape?.isCircle ?? true,
      child: NeumorphicText(
        String.fromCharCode(icon.codePoint),
        textStyle: NeumorphicTextStyle(
          fontSize: size,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
        duration: duration,
        style: isGlassMode
            ? (style ?? const NeumorphicStyle()).copyWith(
                color: (style?.color ?? Colors.white).withValues(alpha: 0.9),
                depth: 0, // Disable depth in glass mode for icons for better clarity
              )
            : style,
        curve: curve,
      ),
    );
  }
}
