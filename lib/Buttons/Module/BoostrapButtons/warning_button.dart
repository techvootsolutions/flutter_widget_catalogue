import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class WarningButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const WarningButton(
      {super.key, required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customTextButton(
      title: title,
      bgColor: const Color(0xFFFFC107),
      onPressed: onPressed,
    );
  }
}
