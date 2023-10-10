import 'dart:ui' as ui show FontFeature;

import 'package:flutter/material.dart' as material;
import 'package:flutter_widget_catalogue/Neumorphic/Module/decoration/neumorphic_text_decorations.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

class NeumorphicTextStyle {
  final bool inherit;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final Locale? locale;
  final List<ui.FontFeature>? fontFeatures;
  final TextDecoration? decoration;
  final String? debugLabel;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;
  final String? package;

  TextStyle get textStyle => TextStyle(
        inherit: inherit,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        fontFeatures: fontFeatures,
        decoration: decoration,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
      );

  NeumorphicTextStyle({
    this.inherit = true,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.locale,
    this.fontFeatures,
    this.decoration,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
  });

  NeumorphicTextStyle copyWith({
    bool? inherit,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    List<ui.FontFeature>? fontFeatures,
    String? debugLabel,
  }) {
    return NeumorphicTextStyle(
      inherit: inherit ?? this.inherit,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      debugLabel: debugLabel ?? this.debugLabel,
    );
  }
}

@immutable
class NeumorphicText extends StatelessWidget {
  final String text;
  final NeumorphicStyle? style;
  final TextAlign textAlign;
  final NeumorphicTextStyle? textStyle;
  final Curve curve;
  final Duration duration;

  const NeumorphicText(
    this.text, {
    Key? key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textAlign = TextAlign.center,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    final NeumorphicStyle style = (this.style ?? const NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    return _NeumorphicText(
      textStyle: (textStyle ?? NeumorphicTextStyle()).textStyle,
      textAlign: textAlign,
      text: text,
      duration: duration,
      style: style,
      curve: curve,
    );
  }
}

class _NeumorphicText extends material.StatefulWidget {
  final String text;

  final NeumorphicStyle style;
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;

  final TextAlign textAlign;

  const _NeumorphicText({
    Key? key,
    required this.duration,
    required this.curve,
    required this.textAlign,
    required this.style,
    required this.textStyle,
    required this.text,
  }) : super(key: key);

  @override
  __NeumorphicTextState createState() => __NeumorphicTextState();
}

class __NeumorphicTextState extends material.State<_NeumorphicText> {
  @override
  Widget build(BuildContext context) {
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr, textAlign: widget.textAlign);
    final textStyle = widget.textStyle;
    textPainter.text = TextSpan(
      text: widget.text,
      style: widget.textStyle,
    );

    return LayoutBuilder(builder: (context, constraints) {
      textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
      final double width = textPainter.width;
      final double height = textPainter.height;

      return DefaultTextStyle(
        style: textStyle,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: widget.curve,
          foregroundDecoration: NeumorphicTextDecoration(
            isForeground: true,
            textStyle: textStyle,
            textAlign: widget.textAlign,
            renderingByPath: true,
            style: widget.style,
            text: widget.text,
          ),
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      );
    });
  }
}
