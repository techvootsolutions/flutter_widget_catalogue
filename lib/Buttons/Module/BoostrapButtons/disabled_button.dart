import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class DisabledButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DisabledButton(
      {super.key, required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customTextButton(
      title: title,
      bgColor: const Color(0xFF6C757D),
      onPressed: onPressed,
    );
  }
}
