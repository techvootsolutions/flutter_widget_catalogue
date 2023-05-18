import 'package:flutter/material.dart';
import 'package:flutter_components/Buttons/Module/custom_buttons.dart';

class DisabledButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const DisabledButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customFlatButton(
        title, const Color(0xFFBFBFC4), onPressed);
  }
}
