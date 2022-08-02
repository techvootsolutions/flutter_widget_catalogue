import 'package:flutter/material.dart';
import 'package:flutter_components/Buttons/Module/custom_buttons.dart';

class SecondaryButtton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const SecondaryButtton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customFlatButton(title, Color(0xFF9742c1), onPressed);
  }
}
