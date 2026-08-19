import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstagramButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final bool? isMinSize;

  const InstagramButton({
    super.key,
    required this.onPressed,
    this.buttonColor,
    this.iconColor,
    this.iconSize,
    this.isMinSize,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      splashColor: Colors.white,
      mini: isMinSize ?? true,
      onPressed: onPressed,
      backgroundColor: buttonColor ?? const Color(0xFFB81877),
      child: FaIcon(
        FontAwesomeIcons.instagram,
        color: iconColor ?? Colors.white,
        size: iconSize,
      ),
    );
  }
}
