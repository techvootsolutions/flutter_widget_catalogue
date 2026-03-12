import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MicrosoftButton extends StatelessWidget {
  final Function onPressed;
  final Color? buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final bool? isMinSize;
  const MicrosoftButton(
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
      splashColor: Colors.black,
      mini: isMinSize ?? true,
      onPressed: onPressed as void Function()?,
      backgroundColor: buttonColor ?? const Color(0xFFF0EFE7),
      child: FaIcon(
        FontAwesomeIcons.microsoft,
        color: iconColor ?? Colors.lightBlue,
        size: iconSize,
      ),
    );
  }
}
