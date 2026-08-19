import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class DarkButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DarkButton({super.key, required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customTextButton(
      title: title,
      bgColor: const Color(0xFF13171F),
      onPressed: onPressed,
    );
  }
}
