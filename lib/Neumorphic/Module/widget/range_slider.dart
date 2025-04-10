import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

typedef NeumorphicRangeSliderLowListener = void Function(double percent);
typedef NeumorphicRangeSliderHighListener = void Function(double percent);

@immutable
class RangeSliderStyle {
  final double depth;
  final bool disableDepth;
  final BorderRadius borderRadius;
  final Color? accent;
  final Color? variant;
  final LightSource? lightSource;

  final NeumorphicBorder border;
  final NeumorphicBorder thumbBorder;

  const RangeSliderStyle({
    this.depth = 0,
    this.disableDepth = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.accent,
    this.lightSource,
    this.variant,
    this.border = const NeumorphicBorder.none(),
    this.thumbBorder = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RangeSliderStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          lightSource == other.lightSource &&
          disableDepth == other.disableDepth &&
          borderRadius == other.borderRadius &&
          thumbBorder == other.thumbBorder &&
          border == other.border &&
          accent == other.accent &&
          variant == other.variant;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      lightSource.hashCode ^
      accent.hashCode ^
      border.hashCode ^
      thumbBorder.hashCode ^
      variant.hashCode;
}

@immutable
class NeumorphicRangeSlider extends StatefulWidget {
  final RangeSliderStyle style;
  final double min;
  final double valueLow;
  final double valueHigh;
  final double max;
  final double height;
  final double? sliderHeight;
  final NeumorphicRangeSliderLowListener? onChangedLow;
  final NeumorphicRangeSliderHighListener? onChangeHigh;
  final Function(ActiveThumb)? onPanStarted;
  final Function(ActiveThumb)? onPanEnded;
  final Widget? thumb;

  const NeumorphicRangeSlider({
    super.key,
    this.style = const RangeSliderStyle(),
    this.min = 0,
    this.max = 10,
    this.valueLow = 0,
    this.valueHigh = 10,
    this.height = 15,
    this.onChangedLow,
    this.onChangeHigh,
    this.onPanStarted,
    this.onPanEnded,
    this.sliderHeight,
    this.thumb,
  });

  double get percentLow => (((valueLow.clamp(min, max)) - min) / ((max - min)));

  double get percentHigh =>
      (((valueHigh.clamp(min, max)) - min) / ((max - min)));

  @override
  createState() => _NeumorphicRangeSliderState();
}

class _NeumorphicRangeSliderState extends State<NeumorphicRangeSlider> {
  late ActiveThumb _activeThumb;
  late bool _canChangeActiveThumb;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return _widget(context, constraints);
    });
  }

  Widget _widget(BuildContext context, BoxConstraints constraints) {
    double thumbSize = widget.height * 1.5;

    // ignore: prefer_function_declarations_over_variables
    Function panUpdate = (DragUpdateDetails details) {
      final tapPos = details.localPosition;
      final newPercent = tapPos.dx / constraints.maxWidth;
      final newValue = ((widget.min + (widget.max - widget.min) * newPercent))
          .clamp(widget.min, widget.max);

      switch (_activeThumb) {
        case ActiveThumb.low:
          if (newValue < widget.valueHigh) {
            _canChangeActiveThumb = false;
            if (widget.onChangedLow != null) {
              widget.onChangedLow!(newValue);
            }
          } else if (_canChangeActiveThumb && details.delta.dx > 0) {
            _canChangeActiveThumb = false;
            _activeThumb = ActiveThumb.high;
          }
          break;
        case ActiveThumb.high:
          if (newValue > widget.valueLow) {
            _canChangeActiveThumb = false;
            if (widget.onChangeHigh != null) {
              widget.onChangeHigh!(newValue);
            }
          } else if (_canChangeActiveThumb && details.delta.dx < 0) {
            _canChangeActiveThumb = false;
            _activeThumb = ActiveThumb.low;
          }
          break;
      }
    };

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: thumbSize / 2, right: thumbSize / 2),
          child: _generateSlider(context),
        ),
        Align(
          alignment: Alignment((widget.percentLow * 2) - 1, 0),
          child: GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                _canChangeActiveThumb = true;
                _activeThumb = ActiveThumb.low;
                if (widget.onPanStarted != null) {
                  widget.onPanStarted!(_activeThumb);
                }
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                panUpdate(details);
              },
              onHorizontalDragEnd: (details) {
                if (widget.onPanEnded != null) {
                  widget.onPanEnded!(_activeThumb);
                }
              },
              child: widget.thumb ??
                  _generateThumb(context, thumbSize, widget.style.variant)),
        ),
        Align(
          alignment: Alignment((widget.percentHigh * 2) - 1, 0),
          child: GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                _canChangeActiveThumb = true;
                _activeThumb = ActiveThumb.high;
                if (widget.onPanStarted != null) {
                  widget.onPanStarted!(_activeThumb);
                }
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                panUpdate(details);
              },
              onHorizontalDragEnd: (details) {
                if (widget.onPanEnded != null) {
                  widget.onPanEnded!(_activeThumb);
                }
              },
              child: widget.thumb ??
                  _generateThumb(context, thumbSize, widget.style.accent)),
        ),
      ],
    );
  }

  Widget _generateSlider(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Stack(alignment: Alignment.center, children: <Widget>[
      NeumorphicProgress(
          duration: Duration.zero,
          percent: 0,
          height: widget.sliderHeight ?? widget.height,
          style: ProgressStyle(
            disableDepth: widget.style.disableDepth,
            depth: widget.style.depth,
            border: widget.style.border,
            borderRadius: widget.style.borderRadius,
            accent: widget.style.accent ?? theme.accentColor,
            variant: widget.style.variant ?? theme.variantColor,
          )),
      Positioned.fill(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.only(
                  left: constraints.biggest.width * widget.percentLow,
                  right: constraints.biggest.width * (1 - widget.percentHigh)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.style.borderRadius,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        widget.style.variant ?? theme.variantColor,
                        widget.style.accent ?? theme.accentColor,
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _generateThumb(BuildContext context, double size, Color? color) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Neumorphic(
      style: NeumorphicStyle(
        disableDepth: widget.style.disableDepth,
        shape: NeumorphicShape.concave,
        color: color ?? theme.accentColor,
        border: widget.style.thumbBorder,
        boxShape: const NeumorphicBoxShape.circle(),
        lightSource: widget.style.lightSource ?? theme.lightSource,
      ),
      child: SizedBox(
        height: size,
        width: size,
      ),
    );
  }
}

enum ActiveThumb { low, high }
