import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkedinButton extends StatelessWidget {
  final Function onPressed;
  final Color? buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final bool? isMinSize;
  const LinkedinButton(
      {super.key,
      required this.onPressed,
      this.buttonColor,
      this.iconColor,
      this.iconSize,
      this.isMinSize});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      splashColor: Colors.white,
      mini: isMinSize ?? true,
      onPressed: onPressed as void Function()?,
      backgroundColor: buttonColor ?? const Color(0xFF0077B5),
      child: Icon(
        FontAwesomeIcons.linkedinIn,
        color: iconColor ?? Colors.white,
        size: iconSize,
      ),
    );
  }
}
