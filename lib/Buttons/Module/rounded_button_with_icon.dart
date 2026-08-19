import 'package:flutter/material.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final String? buttonName;
  final IconData? icon;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? radius;
  final double? iconMargin;

  const RoundedButtonWithIcon({
    super.key,
    required this.onPressed,
    this.title,
    this.buttonName,
    this.icon,
    this.buttonColor,
    this.textStyle,
    this.width,
    this.height,
    this.radius,
    this.iconMargin,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 30.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.favorite),
            SizedBox(width: iconMargin ?? 8.0),
            Text(
              title ?? buttonName ?? "",
              style: textStyle ?? const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
