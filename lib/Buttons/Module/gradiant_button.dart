import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final VoidCallback onPressed;
  final List<Color> colors;

  const GradientButton({
    super.key,
    this.radius,
    this.splashColor,
    this.highlightColor,
    this.textColor,
    this.buttonColor,
    required this.title,
    required this.onPressed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(radius ?? 6.0);
    return Material(
      color: Colors.transparent,
      borderRadius: effectiveRadius,
      child: InkWell(
        borderRadius: effectiveRadius,
        onTap: onPressed,
        splashColor: splashColor ?? Colors.white.withValues(alpha: 0.25),
        highlightColor: highlightColor ?? Colors.white.withValues(alpha: 0.1),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: LinearGradient(colors: colors),
            color: buttonColor,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
