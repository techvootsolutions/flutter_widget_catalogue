import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';

class WarningButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const WarningButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customFlatButton(
        title, const Color(0xFFFF6F10), onPressed);
  }
}
