import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_catalogue/Animations/animation_limiter.dart';

/// Provides animation config (position, duration, delay, columnCount)
/// to descendant [AnimationConfigurator] widgets via InheritedWidget.
class AnimationConfiguration extends InheritedWidget {
  final int position;
  final Duration duration;
  final Duration? delay;
  final int columnCount;

  const AnimationConfiguration._({
    super.key,
    required this.position,
    required this.duration,
    required this.delay,
    required this.columnCount,
    required super.child,
  });

  const AnimationConfiguration.synchronized({
    Key? key,
    Duration duration = const Duration(milliseconds: 225),
    required Widget child,
  }) : this._(
          key: key,
          position: 0,
          duration: duration,
          delay: Duration.zero,
          columnCount: 1,
          child: child,
        );

  /// Children animate with staggered delays based on list position.
  const AnimationConfiguration.staggeredList({
    Key? key,
    required int position,
    Duration duration = const Duration(milliseconds: 225),
    Duration? delay,
    required Widget child,
  }) : this._(
          key: key,
          position: position,
          duration: duration,
          delay: delay,
          columnCount: 1,
          child: child,
        );

  /// Children animate with staggered delays based on grid position.
  const AnimationConfiguration.staggeredGrid({
    Key? key,
    required int position,
    Duration duration = const Duration(milliseconds: 225),
    Duration? delay,
    required int columnCount,
    required Widget child,
  }) : this._(
          key: key,
          position: position,
          duration: duration,
          delay: delay,
          columnCount: columnCount,
          child: child,
        );

  /// Wraps each widget in [children] with a [staggeredList] configuration.
  static List<Widget> toStaggeredList({
    Duration duration = const Duration(milliseconds: 225),
    Duration? delay,
    required Widget Function(Widget) childAnimationBuilder,
    required List<Widget> children,
  }) =>
    children.indexed.map((entry) => AnimationConfiguration.staggeredList(
      position: entry.$1,
      duration: duration,
      delay: delay,
      child: childAnimationBuilder(entry.$2),
    )).toList();

  static AnimationConfiguration? of(BuildContext context) => context.findAncestorWidgetOfExactType<AnimationConfiguration>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// Reads [AnimationConfiguration] from context and drives an [AnimationExecutor].
class AnimationConfigurator extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Widget Function(Animation<double>) animatedChildBuilder;

  const AnimationConfigurator({
    super.key,
    this.duration,
    this.delay,
    required this.animatedChildBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final config = AnimationConfiguration.of(context);
    if (config == null) {
      throw FlutterError.fromParts([
        ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
        ErrorDescription('Use an Animation widget only inside an AnimationConfiguration.'),
        ErrorHint('Wrap your Animation(s) with AnimationConfiguration.synchronized, '
            'staggeredList, or staggeredGrid.'),
      ]);
    }

    return AnimationExecutor(
      duration: duration ?? config.duration,
      delay: _staggerDelay(
        position: config.position,
        duration: duration ?? config.duration,
        delay: delay ?? config.delay,
        columnCount: config.columnCount,
      ),
      builder: (_, controller) => animatedChildBuilder(controller!),
    );
  }

  /// Computes the stagger delay for a given position.
  static Duration _staggerDelay({
    required int position,
    required Duration duration,
    required Duration? delay,
    required int columnCount,
  }) {
    final delayMs = delay?.inMilliseconds ?? duration.inMilliseconds ~/ 6;
    final ms = columnCount > 1
        ? (position ~/ columnCount + position % columnCount) * delayMs
        : position * delayMs;
    return Duration(milliseconds: ms);
  }
}

/// Drives an [AnimationController] after an optional [delay].
class AnimationExecutor extends StatefulWidget {
  final Duration duration;
  final Duration delay;
  final Widget Function(BuildContext, AnimationController?) builder;

  const AnimationExecutor({
    super.key,
    required this.duration,
    this.delay = Duration.zero,
    required this.builder,
  });

  @override
  State<AnimationExecutor> createState() => _AnimationExecutorState();
}

class _AnimationExecutorState extends State<AnimationExecutor> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    if (AnimationLimiter.shouldRunAnimation(context) ?? true) {
      _timer = Timer(widget.delay, _controller.forward);
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => widget.builder(context, _controller),
    );
  }
}
