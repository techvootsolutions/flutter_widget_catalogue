import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final String? buttonName;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? radius;

  const RoundedButton({
    super.key,
    required this.onPressed,
    this.title,
    this.buttonName,
    this.buttonColor,
    this.textStyle,
    this.width,
    this.height,
    this.radius,
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
        child: Text(
          title ?? buttonName ?? "",
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
