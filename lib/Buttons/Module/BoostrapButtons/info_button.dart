import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const InfoButton({super.key, required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customFlatButton(
        title, const Color(0xFF02A4E2), onPressed);
  }
}
