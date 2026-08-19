import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtons {
  static Widget customTextButton({
    required String title,
    required Color bgColor,
    required VoidCallback onPressed,
    bool isIconButton = false,
    IconData icon = Icons.check_circle,
    Color textColor = Colors.white,
  }) {
    return !isIconButton
        ? TextButton(
            style:
                ButtonStyle(backgroundColor: WidgetStateProperty.all(bgColor)),
            onPressed: onPressed,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          )
        : TextButton.icon(
            style:
                ButtonStyle(backgroundColor: WidgetStateProperty.all(bgColor)),
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: textColor,
            ),
            label: Text(
              title,
              style: TextStyle(color: textColor),
            ));
  }

  static Widget customOutlinedButton({
    required String title,
    required Color lineColor,
    required VoidCallback onPressed,
    Color? textColor,
  }) {
    return OutlinedButton(
      style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(color: lineColor))),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: textColor ?? lineColor),
      ),
    );
  }

  static Widget customSignInButton({
    required String title,
    required Color buttonColor,
    required VoidCallback onPressed,
    Color fontColor = Colors.white,
    double fontSize = 24.0,
    IconData icon = Icons.mail,
    FaIconData? faIcon,
  }) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(buttonColor),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12.0))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (faIcon != null) ...[
            FaIcon(
              faIcon,
              color: fontColor,
              size: fontSize,
            ),
          ] else ...[
            Icon(
              icon,
              color: fontColor,
              size: fontSize,
            ),
          ],
          const SizedBox(
            width: 4.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: fontColor,
            ),
          ),
        ],
      ),
    );
  }
}
