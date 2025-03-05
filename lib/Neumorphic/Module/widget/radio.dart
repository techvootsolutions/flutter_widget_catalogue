import 'package:flutter/widgets.dart';

import 'button.dart';
import 'container.dart';

typedef NeumorphicRadioListener<T> = void Function(T value);

class NeumorphicRadioStyle {
  final double? selectedDepth;
  final double? unselectedDepth;
  final bool disableDepth;

  final Color? selectedColor;
  final Color? unselectedColor;

  final double? intensity;
  final NeumorphicShape? shape;

  final NeumorphicBorder border;
  final NeumorphicBoxShape? boxShape;

  final LightSource? lightSource;

  const NeumorphicRadioStyle({
    this.selectedDepth,
    this.unselectedDepth,
    this.selectedColor,
    this.unselectedColor,
    this.lightSource,
    this.disableDepth = false,
    this.boxShape,
    this.border = const NeumorphicBorder.none(),
    this.intensity,
    this.shape,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicRadioStyle &&
          runtimeType == other.runtimeType &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          border == other.border &&
          selectedDepth == other.selectedDepth &&
          unselectedDepth == other.unselectedDepth &&
          selectedColor == other.selectedColor &&
          unselectedColor == other.unselectedColor &&
          boxShape == other.boxShape &&
          intensity == other.intensity &&
          shape == other.shape;

  @override
  int get hashCode =>
      disableDepth.hashCode ^
      selectedDepth.hashCode ^
      lightSource.hashCode ^
      selectedColor.hashCode ^
      unselectedColor.hashCode ^
      boxShape.hashCode ^
      border.hashCode ^
      unselectedDepth.hashCode ^
      intensity.hashCode ^
      shape.hashCode;
}

@immutable
class NeumorphicRadio<T> extends StatelessWidget {
  final Widget? child;
  final T? value;
  final T? groupValue;
  final EdgeInsets padding;
  final NeumorphicRadioStyle style;
  final NeumorphicRadioListener<T?>? onChanged;
  final bool isEnabled;

  final Duration duration;
  final Curve curve;

  const NeumorphicRadio({
    this.child,
    this.style = const NeumorphicRadioStyle(),
    this.value,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.onChanged,
    this.isEnabled = true,
  });

  bool get isSelected => value != null && value == groupValue;

  void _onClick() {
    if (onChanged != null) {
      if (value == groupValue) {
        onChanged!(null);
      } else {
        onChanged!(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    final double selectedDepth =
        -1 * (style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth = (style.unselectedDepth ?? theme.depth).abs();

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!isEnabled) {
      depth = 0;
    }

    final Color unselectedColor = style.unselectedColor ?? theme.baseColor;
    final Color selectedColor = style.selectedColor ?? unselectedColor;

    final Color color = isSelected ? selectedColor : unselectedColor;

    return NeumorphicButton(
      onPressed: () {
        _onClick();
      },
      duration: duration,
      curve: curve,
      padding: padding,
      pressed: isSelected,
      minDistance: selectedDepth,
      style: NeumorphicStyle(
        border: style.border,
        color: color,
        boxShape: style.boxShape,
        lightSource: style.lightSource ?? theme.lightSource,
        disableDepth: style.disableDepth,
        intensity: style.intensity,
        depth: depth,
        shape: style.shape ?? NeumorphicShape.flat,
      ),
      child: child,
    );
  }
}
