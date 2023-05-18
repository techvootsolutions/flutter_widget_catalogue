import 'package:flutter/material.dart';
import 'package:flutter_components/Buttons/Module/custom_buttons.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const InfoButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customFlatButton(
        title, const Color(0xFF02A4E2), onPressed);
  }
}
