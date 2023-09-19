import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class DefaultLineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? textColor;
  const DefaultLineButton(
      {Key? key, required this.title, required this.onPressed, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customOutlinedButton(title, const Color(0xFF0EB0A1),
        onPressed, textColor ?? const Color(0xFF0EB0A1));
  }
}
