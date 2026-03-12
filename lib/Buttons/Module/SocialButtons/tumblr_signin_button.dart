import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/Buttons/Module/custom_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInWithTumblr extends StatelessWidget {
  final Function onPressed;
  final Color? buttonColor;
  final Color? fontColor;
  final double? fontSize;
  final String? title;

  const SignInWithTumblr(
      {super.key,
      required this.onPressed,
      this.buttonColor,
      this.fontColor,
      this.title,
      this.fontSize});
  @override
  Widget build(BuildContext context) {
    return CustomButtons.customSignInButton(
        title: title ?? 'Sign in with Twitter',
        buttonColor: buttonColor ?? const Color.fromRGBO(0, 25, 53, 1),
        onPressed: onPressed,
        fontColor: fontColor ?? Colors.white,
        fontSize: fontSize ?? 24.0,
        faIcon: FontAwesomeIcons.tumblr);
  }
}
