import 'package:flutter/material.dart';
import 'package:flutter_components/Buttons/Module/custom_buttons.dart';

class SuccessLineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? textColor;
  const SuccessLineButton(
      {Key? key, required this.title, required this.onPressed, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customOutlinedButton(title, const Color(0xFF28a745),
        onPressed, textColor ?? const Color(0xFF28a745));
  }
}
