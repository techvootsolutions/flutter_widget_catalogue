import 'dart:math';
import 'package:flutter/widgets.dart';
import 'animation_configuration.dart';

// ─── Shared helper ──────────────────────────────────────────────────────────

/// Creates a curved [Tween] animation from [begin] to [end].
Animation<double> _curvedTween({
  required Animation<double> parent,
  required double begin,
  required double end,
  required Curve curve,
}) =>
    Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: parent, curve: curve),
    );

// ─── FadeInAnimation ─────────────────────────────────────────────────────────

/// Fades a child from transparent to opaque.
class FadeInAnimation extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final Widget child;

  const FadeInAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: (animation) => Opacity(
        opacity: _curvedTween(
          parent: animation,
          begin: 0.0,
          end: 1.0,
          curve: curve,
        ).value,
        child: child,
      ),
    );
  }
}

// ─── FlipAnimation ───────────────────────────────────────────────────────────

enum FlipAxis { x, y }

/// Flips a child in 3D along the X or Y axis.
class FlipAnimation extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final FlipAxis flipAxis;
  final Widget child;

  const FlipAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.flipAxis = FlipAxis.x,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: (animation) {
        final value = _curvedTween(
          parent: animation,
          begin: 0,
          end: 1,
          curve: curve,
        ).value;
        final radians = (1 - value) * pi / 2;
        final transform = flipAxis == FlipAxis.y ? Matrix4.rotationY(radians) : Matrix4.rotationX(radians);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}

// ─── ScaleAnimation ──────────────────────────────────────────────────────────

/// Scales a child from [scale] to 1.0.
class ScaleAnimation extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double scale;
  final Widget child;

  const ScaleAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.scale = 0.0,
    required this.child,
  }) : assert(scale >= 0.0);

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: (animation) => Transform.scale(
        scale: _curvedTween(
          parent: animation,
          begin: scale,
          end: 1.0,
          curve: curve,
        ).value,
        child: child,
      ),
    );
  }
}

// ─── SlideAnimation ──────────────────────────────────────────────────────────

/// Slides a child from an offset to its natural position.
class SlideAnimation extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double verticalOffset;
  final double horizontalOffset;
  final Widget child;

  const SlideAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    double? verticalOffset,
    double? horizontalOffset,
    required this.child,
  })  : verticalOffset = (verticalOffset == null && horizontalOffset == null) ? 50.0 : (verticalOffset ?? 0.0),
        horizontalOffset = horizontalOffset ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: (animation) {
        double animatedOffset(double offset) => _curvedTween(
              parent: animation,
              begin: offset,
              end: 0.0,
              curve: curve,
            ).value;
        return Transform.translate(
          offset: Offset(
            horizontalOffset == 0.0 ? 0.0 : animatedOffset(horizontalOffset),
            verticalOffset == 0.0 ? 0.0 : animatedOffset(verticalOffset),
          ),
          child: child,
        );
      },
    );
  }
}
