import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'neumorphic_emboss_decoration_painter.dart';
import 'neumorphic_text_decoration_painter.dart';

@immutable
class NeumorphicTextDecoration extends Decoration {
  final NeumorphicStyle style;
  final TextStyle textStyle;
  final String text;
  final bool renderingByPath;
  final bool isForeground;
  final TextAlign textAlign;

  const NeumorphicTextDecoration({
    required this.style,
    required this.textStyle,
    required this.isForeground,
    required this.renderingByPath,
    required this.text,
    required this.textAlign,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    if (style.depth != null && style.depth! >= 0) {
      return NeumorphicDecorationTextPainter(
        style: style,
        textStyle: textStyle,
        textAlign: textAlign,
        drawGradient: true,
        drawBackground: !isForeground,
        drawShadow: !isForeground,
        renderingByPath: renderingByPath,
        onChanged: onChanged ?? () {},
        text: text,
      );
    } else {
      return NeumorphicEmptyTextPainter(onChanged: onChanged ?? () {});
    }
  }

  @override
  NeumorphicTextDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null) return scale(t);
    if (a is NeumorphicTextDecoration) {
      return NeumorphicTextDecoration.lerp(a, this, t);
    }
    return super.lerpFrom(a, t) as NeumorphicTextDecoration;
  }

  @override
  NeumorphicTextDecoration? lerpTo(Decoration? b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is NeumorphicTextDecoration) {
      return NeumorphicTextDecoration.lerp(this, b, t);
    }
    return super.lerpTo(b, t) as NeumorphicTextDecoration;
  }

  NeumorphicTextDecoration scale(double factor) {
    return NeumorphicTextDecoration(
        textAlign: textAlign,
        isForeground: isForeground,
        renderingByPath: renderingByPath,
        text: text,
        textStyle: textStyle,
        style: style.copyWith());
  }

  static NeumorphicTextDecoration? lerp(
      NeumorphicTextDecoration? a, NeumorphicTextDecoration? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1.0 - t);
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }

    var aStyle = a.style;
    var bStyle = b.style;

    return NeumorphicTextDecoration(
        isForeground: a.isForeground,
        text: a.text,
        textAlign: a.textAlign,
        textStyle:
            TextStyle.lerp(a.textStyle, b.textStyle, t) ?? const TextStyle(),
        renderingByPath: a.renderingByPath,
        style: a.style.copyWith(
          border: NeumorphicBorder.lerp(aStyle.border, bStyle.border, t),
          intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
          depth: lerpDouble(aStyle.depth, bStyle.depth, t),
          color: Color.lerp(aStyle.color, bStyle.color, t),
          lightSource:
              LightSource.lerp(aStyle.lightSource, bStyle.lightSource, t),
        ));
  }

  @override
  bool get isComplex => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicTextDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          text == other.text &&
          textStyle == other.textStyle &&
          isForeground == other.isForeground &&
          renderingByPath == other.renderingByPath;

  @override
  int get hashCode =>
      style.hashCode ^
      text.hashCode ^
      textStyle.hashCode ^
      isForeground.hashCode ^
      renderingByPath.hashCode;
}
