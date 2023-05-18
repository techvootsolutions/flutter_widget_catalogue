import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_component.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Flutter Buttons",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Simple Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              customContainer(
                  child: SuccessButton(
                title: "Success Button",
                onPressed: () {},
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: DangerButton(
                title: "Danger Button",
                onPressed: () {},
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: PrimaryButton(
                title: "Primary Button",
                onPressed: () {},
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: WarningButton(
                title: "Warning Button",
                onPressed: () {},
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: DisabledButton(
                onPressed: () {},
                title: "Disabled Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: DarkButton(
                onPressed: () {},
                title: "Dark Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                child: ButtonWithIcon(
                  icon: Icons.local_cafe,
                  title: "Icon Button",
                  color: Colors.white,
                  buttonColor: Colors.cyan,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Floating Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              Wrap(
                children: [
                  FloatingIconButton(
                    icon: Icons.home,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  FloatingIconButton(
                    icon: Icons.home,
                    onPressed: () {},
                    buttonColor: Colors.orange,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  FloatingIconButton(
                    icon: Icons.home,
                    onPressed: () {},
                    buttonColor: Colors.cyan,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Line Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              customContainer(
                  child: PrimaryLineButton(
                onPressed: () {},
                title: "Line Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: DefaultLineButton(
                onPressed: () {},
                title: "Default Line Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: SecondaryLineButton(
                onPressed: () {},
                title: "Secoundary Line Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: InfoLineButton(
                textColor: Colors.black,
                onPressed: () {},
                title: "Info Line Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: SuccessLineButton(
                onPressed: () {},
                title: "Success Line Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: WarningLineButton(
                onPressed: () {},
                title: "Warning Line Button",
                textColor: Colors.red,
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: DangerLineButton(
                textColor: Colors.black,
                onPressed: () {},
                title: "Danger Line Button",
              )),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Rounded Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              customContainer(
                  child: RoundedButton(
                onPressed: () {},
                title: "Rounded Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: RoundedButtonWithIcon(
                onPressed: () {},
                icon: Icons.title,
                title: "Rounded Button With Icon",
                buttonColor: Colors.green,
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: RoundedButtonWithIcon(
                onPressed: () {},
                icon: Icons.home,
                title: "Home",
                buttonColor: Colors.blueGrey,
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: InfoButton(
                onPressed: () {},
                title: "Info Button",
              )),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Social Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              Wrap(
                children: <Widget>[
                  FacebookButton(
                    onPressed: () {},
                  ),
                  TwitterButton(
                    onPressed: () {},
                  ),
                  GithubButton(
                    onPressed: () {},
                  ),
                  InstagramButton(
                    onPressed: () {},
                  ),
                  LinkedinButton(
                    onPressed: () {},
                  ),
                  MicrosoftButton(
                    onPressed: () {},
                  ),
                  GoogleButton(
                    onPressed: () {},
                  ),
                ],
              ),
              SignInWithEmail(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithGoogle(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithMicrosoft(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithApple(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithPinterest(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithLinkedin(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithFacebook(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithTwitter(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithInstagram(
                onPressed: () {},
              ),
              const SizedBox(
                height: 5.0,
              ),
              SignInWithGithub(
                onPressed: () {},
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Gradiant Buttons",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              customContainer(
                  child: GradientButton(
                onPressed: () {},
                splashColor: Colors.orange,
                colors: const [
                  Colors.red,
                  Colors.orange,
                ],
                title: "Gradient Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: GradientButton(
                onPressed: () {},
                splashColor: Colors.orange,
                colors: const [
                  Colors.blue,
                  Colors.blueGrey,
                ],
                title: "Gradient Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: GradientButton(
                onPressed: () {},
                splashColor: Colors.orange,
                colors: const [
                  Color(0xFFC33764),
                  Color(0xFF1D2671),
                ],
                title: "Gradient Button",
              )),
              const SizedBox(
                height: 5.0,
              ),
              customContainer(
                  child: GradientButton(
                onPressed: () {},
                splashColor: Colors.orange,
                colors: const [
                  Color(0xFFF7971E),
                  Color(0xFFFFD200),
                ],
                title: "Gradient Button",
              )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customContainer({child}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: child,
  );
}
