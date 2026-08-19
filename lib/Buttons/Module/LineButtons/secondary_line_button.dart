import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class SecondaryLineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? textColor;
  const SecondaryLineButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.textColor});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customOutlinedButton(
      title: title,
      lineColor: const Color(0xFF9742c1),
      onPressed: onPressed,
      textColor: textColor,
    );
  }
}
