import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class LineButton extends StatelessWidget {
  final Color? lineColor;
  final Color? textColor;
  final String title;
  final VoidCallback onPressed;

  const LineButton(
      {super.key,
      this.lineColor,
      required this.title,
      required this.onPressed,
      this.textColor});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customOutlinedButton(
      title: title,
      lineColor: lineColor ?? Colors.green,
      onPressed: onPressed,
      textColor: textColor,
    );
  }
}
