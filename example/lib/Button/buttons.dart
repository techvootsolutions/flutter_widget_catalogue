import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
        title: const Text(
          "Flutter Buttons",
          style: TextStyle(
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection("Simple Buttons", [
              SuccessButton(title: "Success Button", onPressed: () {}),
              DangerButton(title: "Danger Button", onPressed: () {}),
              PrimaryButton(title: "Primary Button", onPressed: () {}),
              WarningButton(title: "Warning Button", onPressed: () {}),
              DisabledButton(title: "Disabled Button", onPressed: () {}),
              DarkButton(title: "Dark Button", onPressed: () {}),
              ButtonWithIcon(
                icon: Icons.local_cafe,
                title: "Icon Button",
                color: Colors.white,
                buttonColor: Colors.cyan,
                onPressed: () {},
              ),
            ]),
            _buildSection("Floating Buttons", [
              Wrap(
                spacing: 8.0,
                children: [
                  FloatingIconButton(icon: Icons.home, onPressed: () {}),
                  FloatingIconButton(
                      icon: Icons.home,
                      onPressed: () {},
                      buttonColor: Colors.orange),
                  FloatingIconButton(
                      icon: Icons.home,
                      onPressed: () {},
                      buttonColor: Colors.cyan,
                      color: Colors.white),
                ],
              ),
            ]),
            _buildSection("Line Buttons", [
              PrimaryLineButton(title: "Line Button", onPressed: () {}),
              DefaultLineButton(title: "Default Line Button", onPressed: () {}),
              SecondaryLineButton(
                  title: "Secondary Line Button", onPressed: () {}),
              InfoLineButton(
                  title: "Info Line Button",
                  textColor: Colors.black,
                  onPressed: () {}),
              SuccessLineButton(title: "Success Line Button", onPressed: () {}),
              WarningLineButton(
                  title: "Warning Line Button",
                  textColor: Colors.red,
                  onPressed: () {}),
              DangerLineButton(
                  title: "Danger Line Button",
                  textColor: Colors.black,
                  onPressed: () {}),
            ]),
            _buildSection("Rounded Buttons", [
              RoundedButton(title: "Rounded Button", onPressed: () {}),
              RoundedButtonWithIcon(
                  title: "Rounded Button With Icon",
                  icon: Icons.title,
                  buttonColor: Colors.green,
                  onPressed: () {}),
              RoundedButtonWithIcon(
                  title: "Home",
                  icon: Icons.home,
                  buttonColor: Colors.blueGrey,
                  onPressed: () {}),
              InfoButton(title: "Info Button", onPressed: () {}),
            ]),
            _buildSection("Social Buttons", [
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  FacebookButton(onPressed: () {}),
                  TwitterButton(onPressed: () {}),
                  GithubButton(onPressed: () {}),
                  InstagramButton(onPressed: () {}),
                  LinkedinButton(onPressed: () {}),
                  MicrosoftButton(onPressed: () {}),
                  GoogleButton(onPressed: () {}),
                ],
              ),
            ]),
            _buildSection("Gradient Buttons", [
              GradientButton(
                  onPressed: () {},
                  splashColor: Colors.orange,
                  colors: const [Colors.red, Colors.orange],
                  title: "Gradient Button"),
              GradientButton(
                  onPressed: () {},
                  splashColor: Colors.orange,
                  colors: const [Colors.blue, Colors.blueGrey],
                  title: "Gradient Button"),
              GradientButton(
                  onPressed: () {},
                  splashColor: Colors.orange,
                  colors: [Color(0xFFC33764), Color(0xFF1D2671)],
                  // colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                  title: "Gradient Button"),
              GradientButton(
                  onPressed: () {},
                  splashColor: Colors.orange,
                  colors: const [Color(0xFFF7971E), Color(0xFFFFD200)],
                  title: "Gradient Button"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10.0),
        ...buttons
            .map((button) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: button))
            .toList(),
        const SizedBox(height: 20.0),
        Divider(thickness: 1, color: Colors.grey.shade300),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
