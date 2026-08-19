import 'package:flutter/material.dart';

class FloatingIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? buttonColor;
  final Color? color;
  final bool? isMinSize;
  final Color? splashColor;
  final Object? heroTag;

  const FloatingIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.buttonColor,
    this.color,
    this.isMinSize,
    this.splashColor,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      splashColor: splashColor ?? Colors.white,
      mini: isMinSize ?? false,
      onPressed: onPressed,
      backgroundColor: buttonColor ?? Colors.red,
      child: Icon(
        icon ?? Icons.favorite,
        color: color ?? Colors.white,
      ),
    );
  }
}
