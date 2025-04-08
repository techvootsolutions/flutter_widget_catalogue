// ignore_for_file: library_prefixes, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Neumorphic/Module/widget/animation/animated_scale.dart'
    as animationScale;
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class NeumorphicSwitchStyle {
  final double? trackDepth;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final NeumorphicShape? thumbShape;
  final double? thumbDepth;
  final LightSource? lightSource;
  final bool disableDepth;

  final NeumorphicBorder thumbBorder;
  final NeumorphicBorder trackBorder;

  const NeumorphicSwitchStyle({
    this.trackDepth,
    this.thumbShape = NeumorphicShape.concave,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbDepth,
    this.lightSource,
    this.disableDepth = false,
    this.thumbBorder = const NeumorphicBorder.none(),
    this.trackBorder = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicSwitchStyle &&
          runtimeType == other.runtimeType &&
          trackDepth == other.trackDepth &&
          trackBorder == other.trackBorder &&
          thumbBorder == other.thumbBorder &&
          lightSource == other.lightSource &&
          activeTrackColor == other.activeTrackColor &&
          inactiveTrackColor == other.inactiveTrackColor &&
          activeThumbColor == other.activeThumbColor &&
          inactiveThumbColor == other.inactiveThumbColor &&
          thumbShape == other.thumbShape &&
          thumbDepth == other.thumbDepth &&
          disableDepth == other.disableDepth;

  @override
  int get hashCode =>
      trackDepth.hashCode ^
      activeTrackColor.hashCode ^
      trackBorder.hashCode ^
      thumbBorder.hashCode ^
      lightSource.hashCode ^
      inactiveTrackColor.hashCode ^
      activeThumbColor.hashCode ^
      inactiveThumbColor.hashCode ^
      thumbShape.hashCode ^
      thumbDepth.hashCode ^
      disableDepth.hashCode;
}

@immutable
class NeumorphicSwitch extends StatelessWidget {
  static const MIN_EMBOSS_DEPTH = -1.0;

  final bool value;
  final ValueChanged<bool>? onChanged;
  final NeumorphicSwitchStyle style;
  final double height;
  final Duration duration;
  final Curve curve;
  final bool isEnabled;

  const NeumorphicSwitch({
    this.style = const NeumorphicSwitchStyle(),
    Key? key,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = const Duration(milliseconds: 200),
    this.value = false,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: GestureDetector(
          onTap: () {
            if (!isEnabled) {
              return;
            }
            if (onChanged != null) {
              onChanged!(!value);
            }
          },
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            style: NeumorphicStyle(
              boxShape: const NeumorphicBoxShape.stadium(),
              lightSource: style.lightSource ?? theme.lightSource,
              border: style.trackBorder,
              disableDepth: style.disableDepth,
              depth: _getTrackDepth(theme.depth),
              shape: NeumorphicShape.flat,
              color: _getTrackColor(theme, isEnabled),
            ),
            child: animationScale.AnimatedScale(
              scale: isEnabled ? 1 : 0,
              alignment:
                  value ? const Alignment(0.5, 0) : const Alignment(-0.5, 0),
              child: AnimatedThumb(
                curve: curve,
                disableDepth: style.disableDepth,
                depth: _thumbDepth,
                duration: duration,
                alignment: _alignment,
                shape: _getThumbShape,
                lightSource: style.lightSource ?? theme.lightSource,
                border: style.thumbBorder,
                thumbColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _alignment {
    if (value) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  double get _thumbDepth {
    if (!isEnabled) {
      return 0;
    } else {
      return style.thumbDepth ?? neumorphicDefaultTheme.depth;
    }
  }

  NeumorphicShape get _getThumbShape {
    return style.thumbShape ?? NeumorphicShape.flat;
  }

  double? _getTrackDepth(double? themeDepth) {
    if (themeDepth == null) return themeDepth;
    final double depth = -1 * (style.trackDepth ?? themeDepth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicSwitch.MIN_EMBOSS_DEPTH);
  }

  Color _getTrackColor(NeumorphicThemeData theme, bool enabled) {
    if (!enabled) {
      return style.inactiveTrackColor ?? theme.baseColor;
    }

    return value == true
        ? style.activeTrackColor ?? theme.accentColor
        : style.inactiveTrackColor ?? theme.baseColor;
  }
}

class AnimatedThumb extends StatelessWidget {
  final Color? thumbColor;
  final Alignment alignment;
  final Duration duration;
  final NeumorphicShape shape;
  final double? depth;
  final Curve curve;
  final bool disableDepth;
  final NeumorphicBorder border;
  final LightSource lightSource;

  const AnimatedThumb({
    Key? key,
    this.thumbColor,
    required this.alignment,
    required this.duration,
    required this.shape,
    this.depth,
    this.curve = Curves.linear,
    this.border = const NeumorphicBorder.none(),
    this.lightSource = LightSource.topLeft,
    this.disableDepth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      curve: curve,
      alignment: alignment,
      duration: duration,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: const NeumorphicBoxShape.circle(),
            disableDepth: disableDepth,
            shape: shape,
            depth: depth,
            color: thumbColor,
            border: border,
            lightSource: lightSource,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: Container(),
              //width: THUMB_WIDTH,
            ),
          ),
        ),
      ),
    );
  }
}
