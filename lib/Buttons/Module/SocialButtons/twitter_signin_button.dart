import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInWithTwitter extends StatelessWidget {
  final Function onPressed;
  final Color? buttonColor;
  final Color? fontColor;
  final double? fontSize;
  final String? title;

  const SignInWithTwitter(
      {Key? key,
      required this.onPressed,
      this.buttonColor,
      this.fontColor,
      this.title,
      this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customSignInButton(
        title ?? 'Sign in with Twitter',
        buttonColor ?? Colors.lightBlue,
        onPressed,
        fontColor ?? Colors.white,
        fontSize ?? 24.0,
        FontAwesomeIcons.twitter);
  }
}
