// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import '../shape/rrect_path_provider.dart';
import '../glass_wrap.dart';

import '../decoration/neumorphic_decorations.dart';
import '../neumorphic_box_shape.dart';
import '../theme/neumorphic_theme.dart';
import 'clipper/neumorphic_box_shape_clipper.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

@immutable
class Neumorphic extends StatelessWidget {
  static const DEFAULT_DURATION = Duration(milliseconds: 100);
  static const DEFAULT_CURVE = Curves.linear;

  static const double MIN_DEPTH = -20.0;
  static const double MAX_DEPTH = 20.0;

  static const double MIN_INTENSITY = 0.0;
  static const double MAX_INTENSITY = 1.0;

  static const double MIN_CURVE = 0.0;
  static const double MAX_CURVE = 1.0;

  final Widget? child;

  final NeumorphicStyle? style;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Curve curve;
  final Duration duration;
  final bool drawSurfaceAboveChild;

  const Neumorphic({
    super.key,
    this.child,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textStyle,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.drawSurfaceAboveChild = true,
    this.isGlassMode = false,
  });

  final bool isGlassMode;

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    var style = (this.style ?? const NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    if (isGlassMode) {
      style = style.copyWith(
        color: style.color == theme.baseColor
            ? material.Colors.white.withValues(alpha: 0.1)
            : style.color?.withValues(alpha: 0.2),
        depth: style.depth != null ? (style.depth! > 0 ? 4.0 : -4.0) : null,
        intensity: 0.9,
        border: style.border.isEnabled
            ? style.border
            : NeumorphicBorder(
                isEnabled: true,
                color: material.Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              ),
      );
    }

    return _NeumorphicContainer(
      padding: padding,
      textStyle: textStyle,
      drawSurfaceAboveChild: drawSurfaceAboveChild,
      duration: duration,
      style: style,
      curve: curve,
      margin: margin,
      isGlassMode: isGlassMode,
      child: child,
    );
  }
}

class _NeumorphicContainer extends StatelessWidget {
  final NeumorphicStyle style;
  final TextStyle? textStyle;
  final Widget? child;
  final EdgeInsets margin;
  final Duration duration;
  final Curve curve;
  final bool drawSurfaceAboveChild;
  final EdgeInsets padding;
  final bool isGlassMode;

  const _NeumorphicContainer({
    this.child,
    this.textStyle,
    required this.padding,
    required this.margin,
    required this.duration,
    required this.curve,
    required this.style,
    required this.drawSurfaceAboveChild,
    this.isGlassMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = style.boxShape ?? const NeumorphicBoxShape.rect();

    return GlassWrap(
      isGlassMode: isGlassMode,
      isCircle: shape.isCircle,
      borderRadius: shape.isRoundRect &&
              shape.customShapePathProvider is RRectPathProvider
          ? (shape.customShapePathProvider as RRectPathProvider).borderRadius
          : BorderRadius.circular(12.0),
      child: DefaultTextStyle(
      style: textStyle ?? material.Theme.of(context).textTheme.bodyMedium!,
      child: AnimatedContainer(
        margin: margin,
        duration: duration,
        curve: curve,
        foregroundDecoration: NeumorphicDecoration(
          isForeground: true,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        decoration: NeumorphicDecoration(
          isForeground: false,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        child: NeumorphicBoxShapeClipper(
          shape: shape,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    ),
    );
  }
}
