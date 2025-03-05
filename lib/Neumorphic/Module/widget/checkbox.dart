// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_widget_catalogue/Neumorphic/Module/neumorphic_icons.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

typedef NeumorphicCheckboxListener<T> = void Function(T value);

/// A Style used to customize a NeumorphicCheckbox
///
/// selectedDepth : the depth when checked
/// unselectedDepth : the depth when unchecked (default : theme.depth)
/// selectedColor : the color when checked (default: theme.accent)
///
class NeumorphicCheckboxStyle {
  final double? selectedDepth;
  final double? unselectedDepth;
  final bool? disableDepth;
  final double? selectedIntensity;
  final double unselectedIntensity;
  final Color? selectedColor;
  final Color? disabledColor;
  final LightSource? lightSource;
  final NeumorphicBorder border;
  final NeumorphicBoxShape? boxShape;

  const NeumorphicCheckboxStyle({
    this.selectedDepth,
    this.border = const NeumorphicBorder.none(),
    this.selectedColor,
    this.unselectedDepth,
    this.disableDepth,
    this.lightSource,
    this.disabledColor,
    this.boxShape,
    this.selectedIntensity = 1,
    this.unselectedIntensity = 0.7,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicCheckboxStyle &&
          runtimeType == other.runtimeType &&
          selectedDepth == other.selectedDepth &&
          border == other.border &&
          unselectedDepth == other.unselectedDepth &&
          disableDepth == other.disableDepth &&
          selectedIntensity == other.selectedIntensity &&
          lightSource == other.lightSource &&
          unselectedIntensity == other.unselectedIntensity &&
          boxShape == other.boxShape &&
          selectedColor == other.selectedColor &&
          disabledColor == other.disabledColor;

  @override
  int get hashCode =>
      selectedDepth.hashCode ^
      unselectedDepth.hashCode ^
      border.hashCode ^
      lightSource.hashCode ^
      disableDepth.hashCode ^
      selectedIntensity.hashCode ^
      unselectedIntensity.hashCode ^
      boxShape.hashCode ^
      selectedColor.hashCode ^
      disabledColor.hashCode;
}

@immutable
class NeumorphicCheckbox extends StatelessWidget {
  final bool value;
  final NeumorphicCheckboxStyle style;
  final NeumorphicCheckboxListener onChanged;
  final isEnabled;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Duration duration;
  final Curve curve;

  const NeumorphicCheckbox({
    super.key,
    this.style = const NeumorphicCheckboxStyle(),
    required this.value,
    required this.onChanged,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(0),
    this.isEnabled = true,
  });

  bool get isSelected => value;

  void _onClick() {
    onChanged(!value);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final selectedColor = style.selectedColor ?? theme.accentColor;

    final double selectedDepth =
        -1 * (style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth = (style.unselectedDepth ?? theme.depth).abs();
    final double selectedIntensity =
        (style.selectedIntensity ?? theme.intensity)
            .abs()
            .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);
    final double unselectedIntensity = style.unselectedIntensity
        .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!isEnabled) {
      depth = 0;
    }

    Color? color = isSelected ? selectedColor : null;
    if (!isEnabled) {
      color = null;
    }

    Color iconColor = isSelected ? theme.baseColor : selectedColor;
    if (!isEnabled) {
      iconColor = theme.disabledColor;
    }

    return NeumorphicButton(
      padding: padding,
      pressed: isSelected,
      margin: margin,
      duration: duration,
      curve: curve,
      onPressed: () {
        if (isEnabled) {
          _onClick();
        }
      },
      drawSurfaceAboveChild: true,
      minDistance: selectedDepth.abs(),
      style: NeumorphicStyle(
        boxShape: style.boxShape,
        border: style.border,
        color: color,
        depth: depth,
        lightSource: style.lightSource ?? theme.lightSource,
        disableDepth: style.disableDepth,
        intensity: isSelected ? selectedIntensity : unselectedIntensity,
        shape: NeumorphicShape.flat,
      ),
      child: Icon(
        NeumorphicIcons.check,
        color: iconColor,
        size: 20.0,
      ),
    );
  }
}
