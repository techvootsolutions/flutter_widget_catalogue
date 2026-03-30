import 'package:flutter/widgets.dart';

/// Limits stagger animations to only the first build frame.
/// Wrap your list/grid root with this to prevent re-animation on rebuild.
class AnimationLimiter extends StatefulWidget {
  final Widget child;

  const AnimationLimiter({super.key, required this.child});

  @override
  State<AnimationLimiter> createState() => _AnimationLimiterState();

  /// Returns whether animations should run for the nearest [AnimationLimiter].
  static bool? shouldRunAnimation(BuildContext context) => context
      .findAncestorWidgetOfExactType<_AnimationLimiterProvider>()
      ?.shouldRunAnimation;
}

class _AnimationLimiterState extends State<AnimationLimiter> {
  bool _shouldRunAnimation = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _shouldRunAnimation = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimationLimiterProvider(
      shouldRunAnimation: _shouldRunAnimation,
      child: widget.child,
    );
  }
}

class _AnimationLimiterProvider extends InheritedWidget {
  final bool shouldRunAnimation;

  const _AnimationLimiterProvider({
    required this.shouldRunAnimation,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
