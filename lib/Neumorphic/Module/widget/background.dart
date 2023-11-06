import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

@immutable
class NeumorphicBackground extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color backendColor;
  final BorderRadius? borderRadius;

  const NeumorphicBackground({super.key,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backendColor = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      color: backendColor,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: AnimatedContainer(
          color: NeumorphicTheme.baseColor(context),
          padding: padding,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      ),
    );
  }
}
