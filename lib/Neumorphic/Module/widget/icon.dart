import 'dart:ui' as ui;
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
    final theme = NeumorphicTheme.currentTheme(context);
    final isGlass = isGlassMode || (style?.isGlass ?? false);

    var updatedStyle =
        (style ?? const NeumorphicStyle()).copyWithThemeIfNull(theme);

    if (isGlass) {
      updatedStyle = updatedStyle.copyWith(
        isGlass: true,
        color: updatedStyle.color == theme.baseColor
            ? Colors.white.withValues(alpha: updatedStyle.glassConnectivity)
            : updatedStyle.color
                ?.withValues(alpha: updatedStyle.glassConnectivity),
        depth: updatedStyle.depth,
        intensity: updatedStyle.intensity,
        border: updatedStyle.border.isEnabled
            ? updatedStyle.border
            : NeumorphicBorder(
                isEnabled: true,
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              ),
      );
    }

    final borderRadius = updatedStyle.boxShape?.isCircle ?? true
        ? BorderRadius.circular(1000)
        : BorderRadius.circular(12); // Default for icons

    Widget content = NeumorphicText(
      String.fromCharCode(icon.codePoint),
      textStyle: NeumorphicTextStyle(
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
      duration: duration,
      style: updatedStyle,
      curve: curve,
    );

    if (isGlass) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: updatedStyle.glassBlur, sigmaY: updatedStyle.glassBlur),
          child: content,
        ),
      );
    }

    return content;
  }
}
