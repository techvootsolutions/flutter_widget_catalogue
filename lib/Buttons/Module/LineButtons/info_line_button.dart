import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class InfoLineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? textColor;
  const InfoLineButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.textColor});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customOutlinedButton(
      title: title,
      lineColor: const Color(0xFF02A4E2),
      onPressed: onPressed,
      textColor: textColor,
    );
  }
}
