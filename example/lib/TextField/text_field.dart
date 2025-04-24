import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class TextFields extends StatefulWidget {
  const TextFields({super.key});
  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
        title: const Text(
          "Flutter TextField",
          style: TextStyle(
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FlutterTextField(
              borderRadius: 20,
              customTextFieldIcon: const Icon(
                Icons.email,
                color: Colors.blue,
              ),
              hintText: "Enter your email",
              textFieldTextStyle: const TextStyle(color: Colors.white),
              trailingWidget: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.blue,
                ),
              ),
              isIconShow: true,
              readOnly: false,
              fillColor: Colors.white,
              borderColor: Colors.blue,
              cursorColor: Colors.black,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              isIconShow: false,
              iconBackgroundColor: Colors.white10,
              borderRadius: 50,
              hintText: "test@gmail.com (read only)",
              readOnly: true,
              borderColor: Colors.blue,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              isIconShow: false,
              iconBackgroundColor: Colors.white10,
              borderRadius: 30,
              isNumber: true,
              hintText: "Enter your number",
              readOnly: false,
              borderColor: Colors.yellow,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              iconBackgroundColor: Colors.black,
              borderRadius: 20,
              customTextFieldIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: "Enter your password",
              isPasswordField: true,
              isIconShow: true,
              readOnly: false,
              fillColor: Colors.white,
              borderColor: Colors.black,
              cursorColor: Colors.black,
              leadingIconColor: Colors.black,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              borderRadius: 20,
              hintText: "Error border",
              readOnly: false,
              fillColor: Colors.white,
              borderColor: Colors.red,
              cursorColor: Colors.red,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              borderRadius: 20,
              hintText: "Disable border",
              readOnly: false,
              fillColor: Colors.white,
              borderColor: Colors.transparent,
              cursorColor: Colors.blue,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              borderRadius: 50,
              hintText: "Fill Color",
              readOnly: false,
              fillColor: Colors.pink,
              borderColor: Colors.transparent,
              cursorColor: Colors.white,
            ),
            const SizedBox(height: 10,),
            const FlutterTextField(
              borderRadius: 50,
              hintText: "Fill Color with border",
              readOnly: false,
              fillColor: Colors.pink,
              borderColor: Colors.black,
              cursorColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
