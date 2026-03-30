import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

typedef NeumorphicSliderListener = void Function(double percent);

@immutable
class SliderStyle {
  final double depth;
  final bool disableDepth;
  final BorderRadius borderRadius;
  final Color? accent;
  final Color? variant;
  final List<Color>? colors;
  final LightSource? lightSource;

  final NeumorphicBorder border;
  final NeumorphicBorder thumbBorder;

  const SliderStyle({
    this.depth = -4,
    this.disableDepth = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.accent,
    this.lightSource,
    this.variant,
    this.colors,
    this.border = const NeumorphicBorder.none(),
    this.thumbBorder = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          borderRadius == other.borderRadius &&
          thumbBorder == other.thumbBorder &&
          border == other.border &&
          accent == other.accent &&
          variant == other.variant &&
          colors == other.colors;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      border.hashCode ^
      lightSource.hashCode ^
      thumbBorder.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      colors.hashCode;
}

@immutable
class NeumorphicSlider extends StatefulWidget {
  final SliderStyle style;
  final double min;
  final double value;
  final double max;
  final double height;
  final NeumorphicSliderListener? onChanged;
  final NeumorphicSliderListener? onChangeStart;
  final NeumorphicSliderListener? onChangeEnd;

  final Widget? thumb;
  final double? sliderHeight;
  final bool isGlassMode;

  const NeumorphicSlider({
    super.key,
    this.style = const SliderStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 15,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
    this.sliderHeight,
    this.isGlassMode = false,
  });

  double get percent => (((value.clamp(min, max)) - min) / ((max - min)));

  @override
  createState() => _NeumorphicSliderState();
}

class _NeumorphicSliderState extends State<NeumorphicSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          final tapPos = details.localPosition;
          final newPercent = tapPos.dx / constraints.maxWidth;
          final newValue =
              ((widget.min + (widget.max - widget.min) * newPercent))
                  .clamp(widget.min, widget.max);

          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        onPanStart: (DragStartDetails details) {
          if (widget.onChangeStart != null) {
            widget.onChangeStart!(widget.value);
          }
        },
        onPanEnd: (details) {
          if (widget.onChangeEnd != null) {
            widget.onChangeEnd!(widget.value);
          }
        },
        child: _widget(context),
      );
    });
  }

  Widget _widget(BuildContext context) {
    double thumbSize = widget.height * 1.5;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: thumbSize / 2, right: thumbSize / 2),
          child: _generateSlider(context),
        ),
        Align(
            alignment: Alignment((widget.percent * 2) - 1, 0),
            child: widget.thumb ?? _generateThumb(context, thumbSize))
      ],
    );
  }

  Widget _generateSlider(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return NeumorphicProgress(
      isGlassMode: widget.isGlassMode,
      duration: Duration.zero,
      percent: widget.percent,
      height: widget.height,
      style: ProgressStyle(
        disableDepth: widget.style.disableDepth,
        depth: widget.style.depth,
        border: widget.style.border,
        lightSource: widget.style.lightSource ?? theme.lightSource,
        borderRadius: widget.style.borderRadius,
        accent: widget.style.accent ?? theme.accentColor,
        variant: widget.style.variant ?? theme.variantColor,
        colors: widget.style.colors,
      ),
    );
  }

  Widget _generateThumb(BuildContext context, double size) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Neumorphic(
      isGlassMode: widget.isGlassMode,
      style: NeumorphicStyle(
        disableDepth: widget.style.disableDepth,
        shape: NeumorphicShape.concave,
        border: widget.style.thumbBorder,
        lightSource: widget.style.lightSource ?? theme.lightSource,
        color: widget.style.accent ?? theme.accentColor,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: SizedBox(
        height: size,
        width: size,
      ),
    );
  }
}
